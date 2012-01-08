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

class ProfilesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    assert_raise(ActionController::RoutingError) {
      get :index
    }
  end

  test "should get new" do
    assert_raise(ActionController::RoutingError) {
      get :new
    }
  end

  test "should create profile" do
    assert_raise(ActionController::RoutingError) {
      post :create, :profile => @profile.attributes
    }
  end

  test "should show profile" do
    get :show, :id => @profile.to_param
    assert_response :success
    assert_not_nil assigns(:profile)
  end

  test "should get edit" do
    get :edit, :id => @profile.to_param
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    get :edit, :id => @profile.to_param
    assert_response :success
    assert_not_nil assigns(:profile)
  end

  test "should update profile" do
    put :update, :id => @profile.to_param, :profile => @profile.attributes
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    put :update, :id => @profile.to_param, :profile => @profile.attributes
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should destroy profile" do
    assert_raise(ActionController::RoutingError) {
      delete :destroy, :id => @profile.to_param
    }
  end
end
