defmodule ThumborClient.UrlBuilder do
  @moduledoc """
  Module to build url with params
  """

  @doc """
  Get full path image passing options.
  """
  def full_path(options) do
    []
    |> trim(options)
    |> meta(options)
    |> fit_in(options)
    |> sizes(options)
    |> crop(options)
    |> align(options, :halign)
    |> align(options, :valign)
    |> smart(options)
    |> filters(options)
    |> image(options)
    |> Enum.join("/")
  end

  @doc """
  Removes surrounding space in image using top-left pixel color unless specified otherwise

  Unless specified trim assumes the top-left pixel color and no tolerance (more on tolerance below).

  To use it, just add a trim: true.

  If you need to specify the orientation from where to get the pixel color, just use trim: "top-left" for the top-left pixel color, for example

  Trim also supports color tolerance. The euclidian distance between the colors of the reference pixel and the surrounding pixels is used. If the distance is within the tolerance they'll get trimmed. For a RGB image the tolerance would be within the range 0-442. The tolerance can be specified like this: trim: "top-left:50"

  ## Examples

  iex> ThumborClient.UrlBuilder.trim(["300x200"], %{trim: "bottom-left"})
  ["300x200", "trim:bottom-left"]

  iex> ThumborClient.UrlBuilder.trim(["300x200"], %{trim: true})
  ["300x200", "trim"]
  """
  def trim(path, options) do
    case options[:trim] do
      nil -> path
      true -> path ++ ["trim"]
      trim -> path ++ ["trim:#{trim}"]
    end
  end

  @doc """
  Instead of get the image, get all meta data informations in image returning using json

  ## Examples

  iex> ThumborClient.UrlBuilder.meta(["300x200"], %{meta: true})
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
  The fit argument specifies that the image should not be auto-cropped and auto-resized to be EXACTLY the specified size,
  and should be fit in an imaginary box of "E" width and "F" height, instead.

  Possible params: [:fit_in, :adaptive_fit_in, :full_fit_in, :adaptive_full_fit_in]
  Param in options: :fit

  ## Example

  iex> ThumborClient.UrlBuilder.fit_in(["200x200"], %{fit: :full_fit_in})
  ["200x200", "full_fit_in"]
  """
  def fit_in(path, options) do
    options_fit = [:fit_in, :adaptive_fit_in, :full_fit_in, :adaptive_full_fit_in]
    fit = Enum.find(options_fit, fn(key) ->
      options[:fit] == key
    end)

    if fit do path ++ [Atom.to_string(fit)] else path end
  end

  @doc """
  Add sizes to url image

  ## Examples

  iex> ThumborClient.UrlBuilder.sizes([], %{width: 300, height: 200})
  ["300x200"]
  """
  def sizes(path, options) do
    [width, height] = sizes_transform(options)
    path ++ ["#{width}x#{height}"]
  end

  def sizes_transform(options) do
    [
      size_transform(:width, options),
      size_transform(:height, options)
    ]
  end

  def size_transform(size_type, options) do
    fill_size_value(options[size_type])
    |> flip(options[if size_type == :width do :flip else :flop end])
  end

  def fill_size_value(size) do
    case size do
      nil -> 0
      _size -> size
    end
  end

  @doc """
  Function to flip values to int
  If second parameter is true: value * -1

  iex> ThumborClient.UrlBuilder.flip(10, true)
  -10

  iex> ThumborClient.UrlBuilder.flip(10, false)
  10
  """
  def flip(size, flip \\ false) do
    size * (if flip == true do -1 else 1 end)
  end

  @doc """
  Manually specify crop window starting from top left coordinates
  top left x, top left y : bottom right x, bottom right y

  ## Examples

  iex> ThumborClient.UrlBuilder.crop([], %{crop: [11, 12, 13, 14]})
  ["11x12:13x14"]
  """
  def crop(path, options) do
    case options[:crop] do
      nil -> path
      [] -> path
      crop -> path ++ ["#{Enum.at(crop, 0)}x#{Enum.at(crop, 1)}:#{Enum.at(crop, 2)}x#{Enum.at(crop, 3)}"]
    end
  end

  @doc """
  Use orientation to crop image.

  Parameters:
  path: List with anothers attributes to build url
  options: Could be: :top, :left, :center, :right, :bottom
  orientation: Could be: :halign or :valign

  ## Examples

  iex> ThumborClient.UrlBuilder.align(["300x200"], %{valign: :top}, :valign)
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

  iex> ThumborClient.UrlBuilder.smart(["300x200"], %{smart: true})
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
  Adding filters to image. The option must be a List of strings.
  You can see all filters in https://github.com/thumbor/thumbor/wiki/Filters

  ## Examples

  iex> ThumborClient.UrlBuilder.filters(["300x300"], %{filters: ["rotate(30)", "brightness(40)"]})
  ["300x300", "filters:rotate(30):brightness(40)"]
  """
  def filters(path, options) do
    case options[:filters] do
      nil -> path
      [] -> path
      _filters -> path ++ [Enum.join(["filters"] ++ options[:filters], ":")]
    end
  end

  @doc """
  Add url image when receive options[:image]

  ## Examples

  iex> ThumborClient.UrlBuilder.image([], %{image: "path/to/image.jpg"})
  ["path/to/image.jpg"]
  """
  def image(path, options) do
    if options[:image] do
      path ++ [options[:image]]
    else
      raise "The option 'image' is required"
    end
  end
end
