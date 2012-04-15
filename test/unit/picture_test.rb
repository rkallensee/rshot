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

class PictureTest < ActiveSupport::TestCase
  fixtures :pictures, :profiles, :picture_metadata, :albums

  # shoulda tests
  should belong_to(:profile)
  should belong_to(:album)
  should have_one(:picture_metadata)
  should have_many(:tags).through(:tag_taggings)
  should have_many(:comments)
  should have_attached_file(:photo)
  should validate_attachment_presence(:photo)
  should validate_attachment_size(:photo).less_than(10.megabytes)
  should validate_presence_of(:profile_id)
  should allow_mass_assignment_of(:title)
  should allow_mass_assignment_of(:photo)
  should allow_mass_assignment_of(:album_id)
  should allow_mass_assignment_of(:tag_list)
  should_not allow_mass_assignment_of(:id)
  should_not allow_mass_assignment_of(:profile_id)
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  should ensure_length_of(:title).is_at_most(150)

  test "picture validations" do
    picture = Picture.new
    assert !picture.save

    assert_raise ActiveModel::MassAssignmentSecurity::Error do
      # mass-assignment of profile_id not allowed
      picture = Picture.new({:profile_id => profiles(:one).id})
      assert !picture.save
    end

    picture = Picture.new
    picture.profile_id = profiles(:one).id
    assert !picture.save

    picture = Picture.new
    picture.profile_id = profiles(:one).id
    picture.photo = sample_file("sample_photo.jpg")
    assert picture.save
  end
end
