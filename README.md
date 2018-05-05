[![Build Status](https://travis-ci.org/globocom/thumbor-client-ex.svg?branch=master)](https://travis-ci.org/globocom/thumbor-client-ex) [![HitCount](http://hits.dwyl.io/globocom/thumbor-client-ex.svg)](http://hits.dwyl.io/globocom/thumbor-client-ex)

# ThumborClient

This package is a client to generate URLs to [Thumbor](https://github.com/thumbor/thumbor) using Elixir language.

## Installation

The package can be installed by adding `thumbor_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:thumbor_client, "~> 0.3.0"}
  ]
end
```

## Usage

### In safe mode

```elixir
iex> client = ThumborClient.client("my_secret_token")
iex> client.(%{image: "path/to/image.jpg", width: 500, height: 500})
"1_6x25QaeExcQVmtuNyrr_lOs-0=/500/500/path/to/image.jpg"
```

### In unsafe mode

```elixir
iex> client = ThumborClient.client()
iex> client.("%{image: "path/to/image.jpg", width: 500, height: 500})
"unsafe/500/500/path/to/image.jpg"
```

### Another way to generate

The method `client("key")` is recommended if you will generate multiple images in same function.
If you prefer, you can call the method generate without this HOF.

```elixir
iex> ThumborClient.generate(%{image: "image.jpg", width: 500, height: 500}, "my_secret_token")
# The last parameter is optional, if not exist should use unsafe mode
```

## Docs

Documentation generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). The docs can
be found at [https://hexdocs.pm/thumbor_client](https://hexdocs.pm/thumbor_client).

