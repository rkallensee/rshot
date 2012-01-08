# encoding: utf-8
#
# rshot (http://rshot.net) - a social digital photo gallery.
# (c) 2011 Raphael Kallensee
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

class Profile < ActiveRecord::Base
  # Paperclip attachment
  has_attached_file :avatar,
    :styles => {
      :micro  => ["25x25#", :jpg],
      :tiny   => ["48x48#", :jpg],
      :medium => ["75x75#", :jpg],
      :big    => ["120x120>", :jpg] }

  # relationships
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  has_many :albums, :dependent => :destroy

  # attribute protection
  attr_accessible :nick, :forename, :surname, :bio, :location, :website, :avatar

  # validators
  validates :nick, :presence => true, :length => { :minimum => 3, :maximum => 50 }
  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_presence_of :user_id

  def to_param
    nick
  end
end
