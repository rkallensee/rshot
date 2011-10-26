require 'test_helper'

class PictureMetadataTest < ActiveSupport::TestCase
  fixtures :pictures, :profiles, :picture_metadata, :albums

  test "picture metadata picture id validation" do
    picturemetadata = PictureMetadata.new
    assert !picturemetadata.save

    picturemetadata = PictureMetadata.new({:picture_id => pictures(:one).id})
    assert picturemetadata.save
  end

  test "picture metadata creation" do
    picture = Picture.new({:profile_id => profiles(:one).id})
    picture.photo = sample_file("sample_photo.jpg")
    assert picture.save

    assert_equal picture.metadata.make, "Canon"
    assert_equal picture.metadata.iso, 125
    assert_equal picture.metadata.aperture, 4.0
    assert_equal picture.metadata.max_aperture_value, nil
  end
end
