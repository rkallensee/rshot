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
  end

  test "should get edit" do
    get :edit, :id => @profile.to_param
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    get :edit, :id => @profile.to_param
    assert_response :success
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
