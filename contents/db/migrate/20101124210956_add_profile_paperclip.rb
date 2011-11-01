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

class AddProfilePaperclip < ActiveRecord::Migration
  def self.up
    add_column :profiles, :avatar_file_name, :string # Original filename
    add_column :profiles, :avatar_content_type, :string # Mime type
    add_column :profiles, :avatar_file_size, :integer # File size in bytes
  end

  def self.down
    remove_column :profiles, :avatar_file_name
    remove_column :profiles, :avatar_content_type
    remove_column :profiles, :avatar_file_size
  end
end
