defmodule TerrariaBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :terraria_bot,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {TerrariaBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.20"},
      {:jason, "~> 1.4"}
    ]
  end
end
