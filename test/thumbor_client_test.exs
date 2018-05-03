defmodule ThumborClientTest do
  use ExUnit.Case

  doctest ThumborClient
  doctest ThumborClient.Url
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

  test "#trim without parameter" do
    assert Url.trim([], %{}) == []
  end

  test "#trim with trim string" do
    assert Url.trim([], %{trim: "bottom-right"}) == ["trim:bottom-right"]
  end

  test "#trim valid without value" do
    assert Url.trim([], %{trim: true}) == ["trim"]
  end

  test "#meta parameter passing" do
    assert Url.meta(["10x10"], %{meta: true}) == ["10x10", "meta"]
  end

  test "#meta without parameter" do
    assert Url.meta(["10x10"], %{}) == ["10x10"]
  end

  test "#align with nil value" do
    assert Url.align(["10x10"], %{}, :valign) == ["10x10"]
  end

  test "#align with center value" do
    assert Url.align(["10x10"], %{valign: :center}, :valign) == ["10x10"]
  end

  test "#align with top value" do
    assert Url.align(["10x10"], %{valign: :top}, :valign) == ["10x10", "top"]
  end

  test "#smart parameter passing" do
    assert Url.smart(["10x10"], %{smart: true}) == ["10x10", "smart"]
  end

  test "#smart without parameter" do
    assert Url.smart(["10x10"], %{}) == ["10x10"]
  end

  test "#image" do
    assert Url.image(["10x10"], %{image: "sun.jpg"}) == ["10x10", "sun.jpg"]
  end
end
