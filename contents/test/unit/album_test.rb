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

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  fixtures :profiles

  test "validate album title length" do
    album = Album.new({:profile_id => 1})
    assert !album.save

    album = Album.new({:title => "12", :profile_id => profiles(:one).id})
    assert !album.save

    album = Album.new({:title => "123", :profile_id => profiles(:one).id})
    assert !album.save # mass-assignment of profile_id not allowed

    album = Album.new({:title => "123"})
    album.profile_id = profiles(:one).id
    assert album.save
  end

  test "validate required album profile id" do
    album = Album.new({:title => "123"})
    assert !album.save

    album = Album.new({:title => "123", :profile_id => profiles(:one).id})
    assert !album.save # mass-assignment of profile_id not allowed

    album = Album.new({:title => "123"})
    album.profile_id = profiles(:one).id
    assert album.save
  end
end
