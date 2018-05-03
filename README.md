# ThumborClient

Thumbor client to Elixir Language.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `thumbor_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:thumbor_client, "~> 0.1.0"}
  ]
end
```

## Usage

### In safe mode

```elixir
iex> client = ThumborClient.client("my_secret_token")
iex> client.("500/500/path/to/image.jpg")
"1_6x25QaeExcQVmtuNyrr_lOs-0=/500/500/path/to/image.jpg"
```

### In unsafe mode

```elixir
iex> client = ThumborClient.client()
iex> client.("500/500/path/to/image.jpg")
"unsafe/500/500/path/to/image.jpg"
```

## Docs

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/thumbor_client](https://hexdocs.pm/thumbor_client).
