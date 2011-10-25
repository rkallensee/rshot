require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "validate album title length" do
    album = Album.new
    assert !album.save

    album = Album.new({:title => "12"})
    assert !album.save

    album = Album.new({:title => "123"})
    assert album.save
  end
end
