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

class PicturesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  fixtures :profiles, :users

  setup do
    @picture = pictures(:one)
  end

  def sign_user_one_in
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:one)
    @user.confirm! if @user.respond_to?(:confirm!) && !@user.confirmed?
    sign_in @user
  end

  test "should get index" do
    get :index, :profile_id => profiles(:one).nick
    assert_response :success
    assert_not_nil assigns(:pictures)
  end

  test "should not get new when not logged in" do
    get :new, :profile_id => profiles(:one).nick
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should get new when logged in" do
    sign_user_one_in

    get :new, :profile_id => profiles(:one).nick
    assert_response :success
  end

  test "should not create picture when not logged in" do
    post :create, {:picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')}, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should create picture when logged in" do
    sign_user_one_in

    assert_difference('Picture.count') do
      post :create, {:picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')}, :profile_id => profiles(:one).nick}
    end

    assert_redirected_to profile_picture_path(profiles(:one), assigns(:picture))
  end

  test "should show picture" do
    get :show, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get :edit, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_user_one_in

    get :edit, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response :success
  end

  test "should not update picture when not logged in" do
    put :update, {:id => @picture.to_param, :picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')},
      :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should throw exception because of mass assignment of unallowed params" do
    sign_user_one_in

    assert_raise(ActiveModel::MassAssignmentSecurity::Error) {
      put :update, {:id => @picture.to_param, :profile_id => profiles(:one).nick, :picture => @picture.attributes}
    }
  end

  test "should update picture when properly logged in" do
    sign_user_one_in

    put :update, {:id => @picture.to_param, :profile_id => profiles(:one).nick, :picture => @picture.attributes.except(
      "id", "created_at", "updated_at", "photo_file_name", "photo_content_type", "photo_file_size", "profile_id")}
    assert_response 200 # picture wasn't updated b/c there's no image in the fixture / put request
    assert !assigns(:picture).valid?
  end

  test "should update picture" do
    sign_user_one_in

    put :update, {:id => @picture.to_param, :picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')},
      :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to profile_picture_path(profiles(:one), @picture)
  end

  test "should not destroy picture when not logged in" do
    delete :destroy, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should destroy picture when logged in" do
    sign_user_one_in

    assert_difference('Picture.count', -1) do
      delete :destroy, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    end

    assert_redirected_to profile_pictures_path(profiles(:one))
  end

  test "should not create comment when not logged in" do
    post :create_comment, {:id => @picture.to_param, :profile_id => profiles(:one).nick, :comment => "Wow, that's nice!"}
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should create comment when logged in" do
    sign_user_one_in

    post :create_comment, {:id => @picture.to_param, :profile_id => profiles(:one).nick, :comment => { :comment => "12"}}
    assert_response :success
    assert_equal 'Please actually type in a comment!', flash[:error]

    assert_difference('Comment.count') do
      post :create_comment, {:id => @picture.to_param, :profile_id => profiles(:one).nick, :comment => { :comment => "Wow, that's nice!"}}
    end

    assert_redirected_to profile_picture_path(profiles(:one), assigns(:picture))
    assert_equal 'Comment was successfully created.', flash[:success]
  end
end
