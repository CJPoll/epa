defmodule Epa.Mixfile do
  use Mix.Project

  def project do
    [app: :epa,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "EPA",
     source_url: "https://github.com/cjpoll/epa",
     homepage_url: "https://github.com/cjpoll/epa",
     docs: [main: "EPA",
            extras: ["README.md"]]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end
end
