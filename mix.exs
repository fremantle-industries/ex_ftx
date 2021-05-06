defmodule ExFtx.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_ftx,
      version: "0.0.10",
      elixir: "~> 1.10",
      package: package(),
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps do
    [
      {:proper_case, "~> 1.0"},
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.1"},
      {:mapail, "~> 1.0.2"},
      {:timex, "~> 3.5"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: [:dev, :test]},
      {:ex_unit_notifier, "~> 1.0", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:uuid, "~> 1.1", only: :test}
    ]
  end

  defp description do
    "FTX API Client for Elixir"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-capital/ex_ftx"}
    }
  end
end
