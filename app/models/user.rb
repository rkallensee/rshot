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

class User < ActiveRecord::Base
  # Include all devise modules.
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :token_authenticatable,
         :confirmable, :timeoutable # :lockable

  # attribute protection
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # attach profile
  has_one :profile, :dependent => :destroy

  # automatically create (empty) profile
  after_create :create_empty_profile

  def create_empty_profile
    profile = Profile.new
    profile.user_id = self.id
    profile.save({:validate => false})
  end
end
