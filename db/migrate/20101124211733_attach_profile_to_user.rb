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

class AttachProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :profiles, :user_id, :integer # has_one relationship

    remove_column :users, :nick
    remove_column :users, :forename
    remove_column :users, :surname
    remove_column :users, :bio
    remove_column :users, :location
    remove_column :users, :website
  end

  def self.down
    remove_column :profiles, :user_id

    add_column :users, :nick, :string
    add_column :users, :forename, :string
    add_column :users, :surname, :string
    add_column :users, :bio, :string
    add_column :users, :location, :string
    add_column :users, :website, :string
  end
end
