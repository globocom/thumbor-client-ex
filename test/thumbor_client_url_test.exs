defmodule ThumborClientUrlBuilderTest do
  use ExUnit.Case
  doctest ThumborClient.UrlBuilder
  alias ThumborClient.UrlBuilder

  ### Testing ThumborClient.URl
  test "#full_path with size and image" do
    assert UrlBuilder.full_path(%{width: 200, height: 300, image: "my-image.jpg"}) == "200x300/my-image.jpg"
  end

  test "#full_path with size, image and smart" do
    assert UrlBuilder.full_path(%{width: 200, height: 300, smart: true, image: "my-image.jpg"}) == "200x300/smart/my-image.jpg"
  end

  test "#trim without parameter" do
    assert UrlBuilder.trim([], %{}) == []
  end

  test "#trim with trim string" do
    assert UrlBuilder.trim([], %{trim: "bottom-right"}) == ["trim:bottom-right"]
  end

  test "#trim valid without value" do
    assert UrlBuilder.trim([], %{trim: true}) == ["trim"]
  end

  test "#meta parameter passing" do
    assert UrlBuilder.meta(["10x10"], %{meta: true}) == ["10x10", "meta"]
  end

  test "#meta without parameter" do
    assert UrlBuilder.meta(["10x10"], %{}) == ["10x10"]
  end

  test "#fit_in with empty value" do
    assert UrlBuilder.fit_in([], %{}) == []
  end

  test "#fit_in with invalid value" do
    assert UrlBuilder.fit_in([], %{fit: :invalid}) == []
  end

  test "#fit_in with fit_in" do
    assert UrlBuilder.fit_in([], %{fit: :fit_in}) == ["fit_in"]
  end

  test "#fit_in with adaptive_fit_in" do
    assert UrlBuilder.fit_in([], %{fit: :adaptive_fit_in}) == ["adaptive_fit_in"]
  end

  test "#fit_in with full_fit_in" do
    assert UrlBuilder.fit_in([], %{fit: :full_fit_in}) == ["full_fit_in"]
  end

  test "#fit_in with adaptive_full_fit_in" do
    assert UrlBuilder.fit_in([], %{fit: :adaptive_full_fit_in}) == ["adaptive_full_fit_in"]
  end

  test "#sizes param with width and height" do
    assert UrlBuilder.sizes([], %{width: 10, height: 20}) == ["10x20"]
  end

  test "#sizes raise error if option width is invalid" do
    assert_raise RuntimeError, ~r/width|height/, fn ->
      UrlBuilder.sizes([], %{height: 10})
    end
  end

  test "#sizes raise error if option height is invalid" do
    assert_raise RuntimeError, ~r/width|height/, fn ->
      UrlBuilder.sizes([], %{width: 10})
    end
  end

  test "#align with nil value" do
    assert UrlBuilder.align(["10x10"], %{}, :valign) == ["10x10"]
  end

  test "#align with center value" do
    assert UrlBuilder.align(["10x10"], %{valign: :center}, :valign) == ["10x10"]
  end

  test "#align with top value" do
    assert UrlBuilder.align(["10x10"], %{valign: :top}, :valign) == ["10x10", "top"]
  end

  test "#smart parameter passing" do
    assert UrlBuilder.smart(["10x10"], %{smart: true}) == ["10x10", "smart"]
  end

  test "#smart without parameter" do
    assert UrlBuilder.smart(["10x10"], %{}) == ["10x10"]
  end

  test "#filters with brightness" do
    assert UrlBuilder.filters([], %{filters: ["brightness(40)"]}) == ["filters:brightness(40)"]
  end

  test "#filters empty" do
    assert UrlBuilder.filters(["10x10"], %{filters: []}) == ["10x10"]
  end

  test "#filters without param" do
    assert UrlBuilder.filters(["10x10"], %{}) == ["10x10"]
  end

  test "#filters with multiple params" do
    assert UrlBuilder.filters(["10x10"], %{filters: ["blur(10)", "noise(20)", "rotate(45)"]}) ==
      ["10x10", "filters:blur(10):noise(20):rotate(45)"]
  end

  test "#image" do
    assert UrlBuilder.image(["10x10"], %{image: "sun.jpg"}) == ["10x10", "sun.jpg"]
  end

  test "#image raise error if option image is invalid" do
    assert_raise RuntimeError, ~r/image/, fn ->
      UrlBuilder.image([], %{})
    end
  end
end
