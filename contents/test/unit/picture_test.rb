require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  fixtures :pictures, :profiles, :picture_metadata, :albums
  test "picture validations" do
    picture = Picture.new
    assert !picture.save

    picture = Picture.new({:profile_id => profiles(:one).id})
    assert !picture.save

    picture = Picture.new({:profile_id => profiles(:one).id})
    picture.photo = sample_file("sample_photo.jpg")
    assert picture.save
  end
end
