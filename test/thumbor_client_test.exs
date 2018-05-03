defmodule ThumborClientTest do
  use ExUnit.Case

  doctest ThumborClient
  alias ThumborClient.Url

  @key "123"
  @path "500/500/image.jpg"

  test "#encrypt_to_thumbor when pass a key" do
    assert ThumborClient.encrypt_to_thumbor(@key, @path) == "VMKhXMULBn4h1UC52W3YliEgFfg="
  end

  test "#encrypt_to_thumbor when using unsafe mode" do
    assert ThumborClient.encrypt_to_thumbor(false, @path) == "unsafe"
  end

  ### Testing ThumborClient.URl
  test "#full_path with size and image" do
    assert Url.full_path(%{width: 200, height: 300, image: "my-image.jpg"}) == "200x300/my-image.jpg"
  end

  test "#full_path with size, image and smart" do
    assert Url.full_path(%{width: 200, height: 300, smart: true, image: "my-image.jpg"}) == "200x300/smart/my-image.jpg"
  end

  test "#smart" do
    assert Url.smart(["10x10"], %{smart: true}) == ["10x10", "smart"]
    assert Url.smart(["10x10"], %{smart: false}) == ["10x10"]
  end

  test "#image" do
    assert Url.image(["10x10"], %{image: "sun.jpg"}) == ["10x10", "sun.jpg"]
  end
end
