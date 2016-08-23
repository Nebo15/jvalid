defmodule SampleUsageTest do
  use ExUnit.Case
  use JValid
  doctest JValid

  # Sample usage when you include schema within module
  use_schema :schema, "test/support/schema.json"

  test "validates used schema" do
    assert valid_schema?(:schema, %{"foo" => "bar"})
    refute valid_schema?(:schema, %{"foo" => 1})
  end

  test "validates inline schema" do
    schema = "test/support/schema.json"
    |> load_schema

    assert valid_schema?(schema, %{"foo" => "bar"})
    refute valid_schema?(schema, %{"foo" => 1})
  end
end
