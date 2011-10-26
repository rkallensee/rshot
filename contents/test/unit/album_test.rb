require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  fixtures :profiles

  test "validate album title length" do
    album = Album.new({:profile_id => 1})
    assert !album.save

    album = Album.new({:title => "12", :profile_id => profiles(:one).id})
    assert !album.save

    album = Album.new({:title => "123", :profile_id => profiles(:one).id})
    assert album.save
  end

  test "validate required album profile id" do
    album = Album.new({:title => "123"})
    assert !album.save

    album = Album.new({:title => "123", :profile_id => profiles(:one).id})
    assert album.save
  end
end
