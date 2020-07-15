defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "0.1.0",
      name: "Issues",
      source_url: "",
      escript: escript_config(),
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      { :httpoison, "~> 1.7" },
      { :poison, "~> 3.1" },
      {:ex_doc, "~> 0.21"}
    ]
  end

  # Add the location of the main class.
  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
