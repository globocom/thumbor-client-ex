defmodule ThumborClientTest do
  use ExUnit.Case

  doctest ThumborClient

  @key "123"
  @path "path/to/image.jpg"

  test "#encrypt_to_thumbor when pass a key" do
    assert ThumborClient.encrypt_to_thumbor(@key, @path) == "CXYhsuabkwiYi7STg9P1EHMnVyY="
  end

  test "#encrypt_to_thumbor when using unsafe mode" do
    assert ThumborClient.encrypt_to_thumbor(false, @path) == "unsafe"
  end

  test "#generate with same value of client" do
    client = ThumborClient.client(@key)
    options = %{width: 20, height: 10, image: @path, smart: true}
    assert client.(options) === ThumborClient.generate(options, @key)
  end

  test "#generate with key and trim" do
    options = %{width: 20, height: 10, image: @path, trim: true}
    assert ThumborClient.generate(options, @key) == "VKudNRI0uT6Ksa_QaVmW3ZAHILs=/trim/20x10/path/to/image.jpg"
  end

  test "#generate with horizontal align" do
    options = %{width: 20, height: 10, image: @path, halign: :left}
    assert ThumborClient.generate(options, @key) == "nEL0THUQpPIvQMo-duIr6gakHcw=/20x10/left/path/to/image.jpg"
  end

  test "#generate with vertical align" do
    options = %{width: 20, height: 10, image: @path, valign: :bottom}
    assert ThumborClient.generate(options, @key) == "cpfZnhhYgp0qmxgfVFCoNoZ1jkU=/20x10/bottom/path/to/image.jpg"
  end

  test "#generate with horizontal and vertical align" do
    options = %{width: 20, height: 10, image: @path, halign: :right, valign: :bottom}
    assert ThumborClient.generate(options, @key) == "u2mOj-6R2bjtCs8YzGxrJlbt37c=/20x10/right/bottom/path/to/image.jpg"
  end

  test "#generate with meta" do
    options = %{width: 20, height: 10, image: @path, meta: true}
    assert ThumborClient.generate(options, @key) == "Mijch4AjWk86uc5tzfHS1ne9pXA=/meta/20x10/path/to/image.jpg"
  end

  test "#generate with filter" do
    options = %{width: 20, height: 10, image: @path, filters: ["rotate(90)"]}
    assert ThumborClient.generate(options, @key) == "369I9wW_9-SfrWUmHgnrVoxbyiA=/20x10/filters:rotate(90)/path/to/image.jpg"
  end
end
