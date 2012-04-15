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

class ProfileTest < ActiveSupport::TestCase
  fixtures :users

  # shoulda tests
  should belong_to(:user)
  should have_many(:pictures)
  should have_many(:albums)
  should have_attached_file(:avatar)
  should validate_attachment_size(:avatar).less_than(2.megabytes)
  should validate_presence_of(:user_id)
  should validate_presence_of(:nick)
  should validate_uniqueness_of(:nick)
  should allow_mass_assignment_of(:nick)
  should allow_mass_assignment_of(:forename)
  should allow_mass_assignment_of(:surname)
  should allow_mass_assignment_of(:bio)
  should allow_mass_assignment_of(:location)
  should allow_mass_assignment_of(:website)
  should allow_mass_assignment_of(:avatar)
  should_not allow_mass_assignment_of(:id)
  should_not allow_mass_assignment_of(:user_id)
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  should ensure_length_of(:nick).is_at_least(3).is_at_most(50)

  test "profile validation" do
    profile = Profile.new
    assert !profile.save

    assert_raise ActiveModel::MassAssignmentSecurity::Error do
      # mass-assignment of user_id not allowed
      profile = Profile.new({:user_id => users(:one).id})
      assert !profile.save
    end

    profile = Profile.new({:nick => "12"})
    assert !profile.save

    profile = Profile.new({:nick => "12"})
    profile.user_id = users(:one).id
    assert !profile.save

    profile = Profile.new({:nick => "123"})
    profile.user_id = users(:one).id
    assert profile.save

    assert_equal profiles(:one).to_param, "raphael"
  end
end
