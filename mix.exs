defmodule ThumborClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :thumbor_client,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      description: "Client to use Thumbor to crop images in Elixir"
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
      {:ex_doc, "~> 0.11", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp package do
    [
      maintainers: ["Tacnoman - Renato Cassino <renatocassino@gmail.com>"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tacnoman/thumbor-client-ex"},
      files: [
        "lib/thumbor_client.ex",
        "lib/thumbor_client_url.ex",
        "mix.exs",
        "README.md",
        "LICENSE",
        "CHANGELOG.md"
      ]
    ]
  end
end
