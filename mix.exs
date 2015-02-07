defmodule RepeatexApi.Mixfile do
  use Mix.Project

  def project do
    [app: :repeatex_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {RepeatexApi, []},
     applications: [:phoenix, :cowboy, :logger, :repeatex, :poison]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, github: "phoenixframework/phoenix", ref: "fa08d98d2f79c2b1a65b615d32629b6c19184a68"},
      {:cowboy, "~> 1.0"},
      {:repeatex, github: "rcdilorenzo/repeatex"},
      {:exrm, "~> 0.14.16"}
    ]
  end
end
