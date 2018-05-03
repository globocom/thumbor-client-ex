defmodule ThumborClient.Url do
  @moduledoc """
  Module to create url with params
  """

  def full_path(options) do
    path = []
    |> sizes(options)
    |> smart(options)
    |> image(options)

    Enum.join(path, "/")
  end

  @doc """
  Add url image when receive options[:image]

  ## Examples

  iex> ThumborClient.Url.image([], %{image: "path/to/image.jpg"})
  ["path/to/image.jpg"]
  """
  def image(path, options) do
    path ++ [options[:image]]
  end

  @doc """
  Add sizes to url image

  ## Examples

  iex> ThumborClient.Url.sizes([], %{width: 300, height: 200})
  ["300x200"]
  """
  def sizes(path, options) do
    width = options[:width]
    height = options[:height]

    path ++ ["#{width}x#{height}"]
  end

  @doc """
  Add url parameter smart to crop better images

  ## Examples

  iex> ThumborClient.Url.smart(["300x200"], %{smart: true})
  ["300x200", "smart"]
  """
  def smart(path, options) do
    if options[:smart] do
      path ++ ["smart"]
    else
      path
    end
  end
end
