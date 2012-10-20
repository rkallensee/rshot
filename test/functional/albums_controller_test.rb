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

class AlbumsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  fixtures :profiles, :users

  setup do
    @album = albums(:one)
  end

  def sign_user_one_in
    @user = users(:one)
    @user.confirm! if @user.respond_to?(:confirm!) && !@user.confirmed?
    sign_in @user
  end

  test "should get index" do
    get :index, :profile_id => profiles(:one).nick
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    get :new, :profile_id => profiles(:one).nick
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_user_one_in

    get :new, :profile_id => profiles(:one).nick
    assert_response :success
  end

  test "should create album" do
    post :create, {:profile_id => profiles(:one).nick, :album => @album.attributes.except(
      "id", "created_at", "updated_at", "profile_id")}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_user_one_in

    assert_difference('Album.count') do
      post :create, {:profile_id => profiles(:one).nick, :album => @album.attributes.except(
        "id", "created_at", "updated_at", "profile_id")}
    end

    assert_redirected_to profile_album_path(profiles(:one), assigns(:album))
  end

  test "should show album" do
    get :show, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_user_one_in

    get :edit, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    assert_response :success
  end

  test "should update album" do
    put :update, {:profile_id => profiles(:one).nick, :id => @album.to_param, :album => @album.attributes.except(
      "id", "created_at", "updated_at", "profile_id")}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_user_one_in

    put :update, {:profile_id => profiles(:one).nick, :id => @album.to_param, :album => @album.attributes.except(
      "id", "created_at", "updated_at", "profile_id")}
    assert_redirected_to profile_album_path(profiles(:one), assigns(:album))
  end

  test "should destroy album" do
    delete :destroy, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_user_one_in

    assert_difference('Album.count', -1) do
      delete :destroy, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    end

    assert_redirected_to profile_albums_path(profiles(:one))
  end
end
