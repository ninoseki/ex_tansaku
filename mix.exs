defmodule ExTansaku.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_tansaku,
      version: "0.1.1",
      escript: escript(),
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A yet another dirbuster tool",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      source_url: "https://github.com/ninoseki/ex_tansaku",
      package: package()
    ]
  end

  defp escript do
    [
      main_module: ExTansaku.CLI
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:fake_server, "~> 1.5", only: :test},
      {:httpoison, "~> 1.5"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp package() do
    [
      maintainers: ["Manabu Niseki"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ninoseki/ex_tansaku"}
    ]
  end
end
