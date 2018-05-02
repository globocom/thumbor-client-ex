defmodule ThumborClientTest do
  use ExUnit.Case
  doctest ThumborClient
  @key "123"
  @path "500/500/image.jpg"

  test "#encrypt_to_thumbor" do
    assert ThumborClient.encrypt_to_thumbor(@key, @path) == "VMKhXMULBn4h1UC52W3YliEgFfg="
  end

  test "#client to generate url" do
    client = ThumborClient.client(@key)
    assert client.(@path) == "VMKhXMULBn4h1UC52W3YliEgFfg=/500/500/image.jpg"
  end
end
