defmodule ThumborClient.Url do
  @moduledoc """
  Module to create url with params
  """

  def full_path(options) do
    []
    |> trim(options)
    |> meta(options)
    |> sizes(options)
    |> align(options, :halign)
    |> align(options, :valign)
    |> smart(options)
    |> image(options)
    |> Enum.join("/")
  end

  def trim(path, options) do
    case options[:trim] do
      nil -> path
      true -> path ++ ["trim"]
      trim -> path ++ ["trim:#{trim}"]
    end
  end

  @doc """
  Add sizes to url image

  ## Examples

  iex> ThumborClient.Url.meta(["300x200"], %{meta: true})
  ["300x200", "meta"]
  """
  def meta(path, options) do
    case options[:meta] do
      nil -> path
      false -> path
      _ -> path ++ ["meta"]
    end
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
  Use orientation to crop image.

  Parameters:
  path: List with anothers attributes to build url
  options: Could be: :top, :left, :center, :right, :bottom
  orientation: Could be: :halign or :valign

  ## Examples

  iex> ThumborClient.Url.align(["300x200"], %{valign: :top}, :valign)
  ["300x200", "top"]
  """
  def align(path, options, orientation) do
    case options[orientation] do
      nil -> path
      false -> path
      :center -> path
      position -> path ++ [Atom.to_string(position)]
    end
  end

  @doc """
  Add url parameter smart to crop better images.
  Thumbor has algorithms to crop using facial recognition process.

  ## Examples

  iex> ThumborClient.Url.smart(["300x200"], %{smart: true})
  ["300x200", "smart"]
  """
  def smart(path, options) do
    case options[:smart] do
      nil -> path
      false -> path
      _ -> path ++ ["smart"]
    end
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
end
