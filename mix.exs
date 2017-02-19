defmodule LiveOdds.Mixfile do
  use Mix.Project

  def project do
    [app: :live_odds,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     test_coverage: [tool: ExCoveralls],
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:mix_test_watch, "> 0.0.0", only: :dev, runtime: false},
     {:dogma, "> 0.0.0", only: :dev},
     {:credo, "> 0.0.0", only: [:dev, :test]},
     {:ex_doc, "> 0.0.0", only: :dev},
     {:excoveralls, "> 0.0.0", only: :test},
     {:dialyxir, "> 0.0.0", only: :dev, runtime: false}
    ]
  end
end
