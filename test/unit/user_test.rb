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

class UserTest < ActiveSupport::TestCase
  fixtures :users, :profiles

  # shoulda tests
  should have_one(:profile)
  should allow_mass_assignment_of(:email)
  should allow_mass_assignment_of(:password)
  should allow_mass_assignment_of(:password_confirmation)
  should allow_mass_assignment_of(:remember_me)
  should_not allow_mass_assignment_of(:id)
  should_not allow_mass_assignment_of(:encrypted_password)
  should_not allow_mass_assignment_of(:password_salt)
  should_not allow_mass_assignment_of(:reset_password_token)
  should_not allow_mass_assignment_of(:remember_token)
  should_not allow_mass_assignment_of(:remember_created_at)
  should_not allow_mass_assignment_of(:sign_in_count)
  should_not allow_mass_assignment_of(:current_sign_in_at)
  should_not allow_mass_assignment_of(:last_sign_in_at)
  should_not allow_mass_assignment_of(:current_sign_in_ip)
  should_not allow_mass_assignment_of(:last_sign_in_ip)
  should_not allow_mass_assignment_of(:confirmation_token)
  should_not allow_mass_assignment_of(:confirmed_at)
  should_not allow_mass_assignment_of(:confirmation_sent_at)
  should_not allow_mass_assignment_of(:failed_attempts)
  should_not allow_mass_assignment_of(:unlock_token)
  should_not allow_mass_assignment_of(:locked_at)
  should_not allow_mass_assignment_of(:authentication_token)
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)

  test "user model basics" do
    user = User.new
    assert !user.save

    user = User.new({:email => "foo@bar.net"})
    user.password = "bacardi"
    user.password_salt = "b4z"
    assert user.valid?
    assert user.save

    profile = Profile.last
    # find out if the profile was automatically created
    assert_equal profile, user.profile
  end
end
