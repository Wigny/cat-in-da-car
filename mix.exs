defmodule CatInDaCar.MixProject do
  use Mix.Project

  def project do
    [
      app: :cat_in_da_car,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CatInDaCar.Application, []}
    ]
  end

  defp deps do
    [
      {:bumblebee, "~> 0.4.2"},
      {:nx, "~> 0.6.4"},
      {:exla, "~> 0.6.4"},
      {:axon, "~> 0.6.0"},
      {:kino, "~> 0.12.3"},
      {:evision, "~> 0.1.34"},
      {:telegram, github: "visciang/telegram", tag: "1.2.1"},
      {:finch, "~> 0.17.0"}
    ]
  end
end
