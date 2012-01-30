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

class AddDeviseReconfirmable < ActiveRecord::Migration
  def self.up
    add_column :users, :unconfirmed_email, :string # necessary for Devise Reconfirmable
    add_column :users, :reset_password_sent_at, :datetime
    remove_column :users, :remember_token # remove unnecessary field (not used in Devise 2.0)
  end

  def self.down
    remove_column :users, :unconfirmed_email
    remove_column :users, :reset_password_sent_at
    add_column :users, :unconfirmed_email, :string
  end
end