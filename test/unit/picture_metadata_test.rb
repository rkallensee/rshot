# encoding: utf-8
#
# rshot (http://rshot.net) - a social digital photo gallery.
# (c) 2011-2012 Raphael Kallensee
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'test_helper'

class PictureMetadataTest < ActiveSupport::TestCase
  fixtures :pictures, :profiles, :picture_metadata, :albums

  # shoulda tests
  should belong_to(:picture)
  should validate_presence_of(:picture_id)
  should_not allow_mass_assignment_of(:id)
  should_not allow_mass_assignment_of(:picture_id)
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)

  test "picture metadata picture id validation" do
    picturemetadata = PictureMetadata.new
    assert !picturemetadata.save

    picturemetadata = PictureMetadata.new
    picturemetadata.picture_id = pictures(:one).id
    assert picturemetadata.save
  end

  test "picture metadata creation" do
    picture = Picture.new
    picture.profile_id = profiles(:one).id
    picture.photo = sample_file("sample_photo.jpg")
    assert picture.save

    assert_equal picture.metadata.make, "Canon"
    assert_equal picture.metadata.iso, 125
    assert_equal picture.metadata.aperture, 4.0
    assert_equal picture.metadata.max_aperture_value, nil
  end
end
