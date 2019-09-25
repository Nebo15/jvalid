defmodule JValid.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :jvalid,
      description: "Json Schema validation helper, that allows to store schemes in a separate files.",
      package: package(),
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [] ++ Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      docs: [source_ref: "v#\{@version\}", main: "readme", extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :nex_json_schema, :jason]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:jason, "~> 1.1"},
      {:nex_json_schema, ">= 0.8.0"},
      {:benchfella, "~> 0.3", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test]},
      {:excoveralls, "~> 0.11.2", only: [:dev, :test]},
      {:credo, ">= 0.4.8", only: [:dev, :test]}
    ]
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [
      contributors: ["Nebo #15"],
      maintainers: ["Nebo #15"],
      licenses: ["LISENSE.md"],
      links: %{github: "https://github.com/Nebo15/jvalid"},
      files: ~w(lib LICENSE.md mix.exs README.md)
    ]
  end
end
