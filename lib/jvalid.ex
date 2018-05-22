defmodule JValid do
  @moduledoc """
  Macro allows to include JSON Schema into your code and validate maps based on them.
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import JValid

      @schemas []
    end
  end

  @doc """
    Load schema at compile time to be later used in validator.
    This macro will include in inline in a module scope.
    It can save resources and reduce application size.

    Example:
        defmodule Sample
          use_schema :schema, "test/support/schema.json"
        end
  """
  defmacro use_schema(name, file) when is_atom(name) and is_binary(file) do
    quote bind_quoted: binding() do
      source =
        file
        |> File.read!()
        |> Poison.decode!()
        |> NExJsonSchema.Schema.resolve()

      @schemas [{name, source} | @schemas]
    end
  end

  @doc """
    Load schema at compile time to be later used in validator.
    This macro will include in inline in a function scope.

    Example:

        schema = load_schema "test/support/schema.json"
  """
  defmacro load_schema(file) when is_binary(file) do
    quote bind_quoted: binding() do
      file
      |> File.read!()
      |> Poison.decode!()
      |> NExJsonSchema.Schema.resolve()
    end
  end

  @doc """
    Validate map using previously loaded schema.
    Returns true if schema is valid.

    Example:

        use JValid

        # Include schema in a module scope
        use_schema :schema, "test/support/schema.json"
        # ...
        valid_schema?(:schema, map)

        # Include schema in a function scope
        "test/support/schema.json"
        |> load_schema
        |> valid_schema?(map)
  """
  defmacro valid_schema?(schema, map) when is_atom(schema) do
    quote bind_quoted: binding() do
      @schemas
      |> Keyword.get(schema)
      |> NExJsonSchema.Validator.valid?(map)
    end
  end

  defmacro valid_schema?(schema, map) do
    quote bind_quoted: binding() do
      schema
      |> NExJsonSchema.Validator.valid?(map)
    end
  end

  @doc """
    Validate map using previously loaded schema.
    Returns `:ok` if map is valid, otherwise - `{:error, reason}`.

    Example:

        use JValid

        # Include schema in a module scope
        use_schema :schema, "test/support/schema.json"
        # ...
        validate_schema?(:schema, map)

        # Include schema in a function scope
        "test/support/schema.json"
        |> load_schema
        |> validate_schema?(map)
  """
  defmacro validate_schema(schema, map) when is_atom(schema) do
    quote bind_quoted: binding() do
      @schemas
      |> Keyword.get(schema)
      |> NExJsonSchema.Validator.validate(map)
    end
  end

  defmacro validate_schema(schema, map) do
    quote bind_quoted: binding() do
      schema
      |> NExJsonSchema.Validator.validate(map)
    end
  end
end
