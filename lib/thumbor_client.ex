defmodule ThumborClient do
  @moduledoc """
  Documentation for ThumborClient.
  """

  alias ThumborClient.Url

  def encrypt_to_thumbor(false, _path) do
    "unsafe"
  end

  @doc """
  Encrypt to Thumbor. Thumbor requires an specific encryption to work.
  The encryption is a HMAC-SHA1 using the secret key setted in thumbor server and the path.
  After encrypt with HMAC-SHA1, must be encrypted with Base64 url_encode.

  ## Examples

  iex> ThumborClient.encrypt_to_thumbor("123", "500/500/image.jpg")
  "VMKhXMULBn4h1UC52W3YliEgFfg="
  """
  def encrypt_to_thumbor(secret, path) do
    :crypto.hmac(:sha, secret, path)
    |> Base.url_encode64
  end

  @doc """
  Method to get the Thumbor Client
  This methods is a HOF to return the client of Thumbor

  ## Examples

  iex> client = ThumborClient.client("123")
  iex> client.(%{image: "image.jpg", width: 500, height: 400, smart: true})
  "rFZk5DrMK2hKAwVMJU4O4ZYDpeI=/500x400/smart/image.jpg"
  """
  def client(secret \\ false) do
    my_secret = secret

    fn(options) ->
      ThumborClient.generate(options, my_secret)
    end
  end

  @doc """
  Method to generate image passing parameters

  ## Examples
  iex> ThumborClient.generate(%{width: 200, height: 200, image: "my-image.jpg"}, "123")
  "gliOovhxLB8RGXinV2YT_W607lw=/200x200/my-image.jpg"

  OR
  iex> ThumborClient.generate(%{width: 200, height: 200, image: "my-image.jpg"})
  "unsafe/200x200/my-image.jpg"
  """
  def generate(options, secret \\ false) do
    full_path = Url.full_path(options)
    encrypt_key = encrypt_to_thumbor(secret, full_path)

    "#{encrypt_key}/#{full_path}"
  end
end
