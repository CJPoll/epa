defmodule Epa.Mixfile do
  use Mix.Project

  def project do
    [app: :epa,
     version: "0.1.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "EPA",
     package: [
       description: "Simple helpers to validate your ENV config is correct",
       licenses: ["MIT"],
       maintainers: ["cjpoll@gmail.com"],
       links: %{
         home: "https://github.com/cjpoll/epa",
         source: "https://github.com/cjpoll/epa"
       }
     ],
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
