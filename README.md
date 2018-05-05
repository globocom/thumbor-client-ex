[![Build Status](https://travis-ci.org/globocom/thumbor-client-ex.svg?branch=master)](https://travis-ci.org/globocom/thumbor-client-ex) [![HitCount](http://hits.dwyl.io/globocom/thumbor-client-ex.svg)](http://hits.dwyl.io/globocom/thumbor-client-ex)

# ThumborClient

This package is a client to generate URLs to [Thumbor](https://github.com/thumbor/thumbor) using Elixir language.

## Installation

The package can be installed by adding `thumbor_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:thumbor_client, "~> 0.4.0"}
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

## Options

|      Option       | Default Value |                                                                                               Description                                                                                               |
|-------------------|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| trim: (bool)      | false         | Removes surrounding space in image using top-left pixel color unless specified otherwise                                                                                                               |
| meta: (bool)      | false         | Instead of get the image, get all meta data informations in image returning using json                                                                                                                  |
| fit: (atom\|nil)   | nil           | The fit argument specifies that the image should not be auto-cropped and auto-resized to be EXACTLY the specified size. Possible values: :fit_in, :adaptive_fit_in, :full_fit_in, :adaptive_full_fit_in |
| width: (integer)  | 0             | Final width of image                                                                                                                                                                                    |
| height: (integer) | 0             | Final height of image                                                                                                                                                                                   |
| flip: (bool)      | false         | Flip image horizontaly                                                                                                                                                                                  |
| flop: (bool)      | false         | Flip image verticaly                                                                                                                                                                                    |
| halign: (atom)    | :center       | Orientation to crop horizontaly. Possible values: `:left`, `:center`, `:right`                                                                                                                                |
| valign: (atom)    | :center       | Orientation to crop verticaly. Possible values: `:top`, `:center`, `:bottom`                                                                                                                                  |
| smart: (bool)     | false         | Use Thumbor algorithms to crop using facial recognition process                                                                                                                                         |
| filters: (list)   | []            | Adding filters to image. More details bellow                                                                                                                                                            |
| image: (string)   | nil           | Path of image. Can be external.                                                                                                                                                                         |

## Filters

You can see a big list of filters in official [Thumbor documentation](https://github.com/thumbor/thumbor/wiki/Filters). You must set a list of strings with values.

Examples of usage:

#### Brightness

```elixir
ThumborClient.generate(%{filters: ["brightness(40)"], width: 400, height: 300, path: "/path/image.jpg"})
```
#### Blur

```elixir
ThumborClient.generate(%{filters: ["blur(40)"], width: 400, height: 300, path: "/path/image.jpg"})
```

#### Grayscale

```elixir
ThumborClient.generate(%{filters: ["grayscale()"], width: 400, height: 300, path: "/path/image.jpg"})
```

#### Multiple filters

```elixir
ThumborClient.generate(%{filters: ["grayscale()", "rotate(90)", "saturate(20)"], width: 400, height: 300, path: "/path/image.jpg"})
```

## Docs

The docs can be found at [https://hexdocs.pm/thumbor_client](https://hexdocs.pm/thumbor_client).

