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

class AlbumTest < ActiveSupport::TestCase
  fixtures :profiles

  # shoulda tests
  should belong_to(:profile)
  should have_many(:pictures)
  should validate_presence_of(:title)
  should validate_presence_of(:profile_id)
  should_not allow_mass_assignment_of(:id)
  should_not allow_mass_assignment_of(:profile_id)
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  should_not allow_value("(1").for(:title)
  should allow_value("(12").for(:title)
  should ensure_length_of(:title).is_at_least(3).is_at_most(150)

  test "validate album title length" do
    album = Album.new
    album.profile_id = 1
    assert !album.save

    album = Album.new({:title => "12"})
    album.profile_id = profiles(:one).id
    assert !album.save

    assert_raise ActiveModel::MassAssignmentSecurity::Error do
      # mass-assignment of profile_id not allowed
      album = Album.new({:title => "123", :profile_id => profiles(:one).id})
    end

    album = Album.new({:title => "123"})
    album.profile_id = profiles(:one).id
    assert album.save
  end

  test "validate required album profile id" do
    album = Album.new({:title => "123"})
    assert !album.save

    assert_raise ActiveModel::MassAssignmentSecurity::Error do
      album = Album.new({:title => "123", :profile_id => profiles(:one).id})
      assert !album.save # mass-assignment of profile_id not allowed
    end

    album = Album.new({:title => "123"})
    album.profile_id = profiles(:one).id
    assert album.save
  end
end
