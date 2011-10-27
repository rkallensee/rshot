require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  fixtures :profiles, :users

  setup do
    @album = albums(:one)
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

    sign_in :user, users(:one)

    get :new, :profile_id => profiles(:one).nick
    assert_response :success
  end

  test "should create album" do
    post :create, {:profile_id => profiles(:one).nick, :album => @album.attributes}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    assert_difference('Album.count') do
      post :create, {:profile_id => profiles(:one).nick, :album => @album.attributes}
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

    sign_in :user, users(:one)

    get :edit, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    assert_response :success
  end

  test "should update album" do
    put :update, {:profile_id => profiles(:one).nick, :id => @album.to_param, :album => @album.attributes}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    put :update, {:profile_id => profiles(:one).nick, :id => @album.to_param, :album => @album.attributes}
    assert_redirected_to profile_album_path(profiles(:one), assigns(:album))
  end

  test "should destroy album" do
    delete :destroy, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    assert_difference('Album.count', -1) do
      delete :destroy, {:profile_id => profiles(:one).nick, :id => @album.to_param}
    end

    assert_redirected_to profile_albums_path(profiles(:one))
  end
end
