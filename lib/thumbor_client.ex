defmodule ThumborClient do
  @moduledoc """
  Documentation for ThumborClient.
  """

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
  iex> client.("500/500/image.jpg")
  "VMKhXMULBn4h1UC52W3YliEgFfg=/500/500/image.jpg"
  """
  def client(secret \\ false) do
    my_secret = secret

    fn(path) ->
      encrypt_key = encrypt_to_thumbor(my_secret, path)

      "#{encrypt_key}/#{path}"
    end
  end
end
