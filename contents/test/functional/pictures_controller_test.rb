require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  fixtures :profiles, :users

  setup do
    @picture = pictures(:one)
  end

  test "should get index" do
    get :index, :profile_id => profiles(:one).nick
    assert_response :success
    assert_not_nil assigns(:pictures)
  end

  test "should get new" do
    get :new, :profile_id => profiles(:one).nick
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    get :new, :profile_id => profiles(:one).nick
    assert_response :success
  end

  test "should create picture" do
    post :create, {:picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')}, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    assert_difference('Picture.count') do
      post :create, {:picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')}, :profile_id => profiles(:one).nick}
    end

    assert_redirected_to profile_picture_path(profiles(:one), assigns(:picture))
  end

  test "should show picture" do
    get :show, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    get :edit, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response :success
  end

  test "should update picture" do
    put :update, {:id => @picture.to_param, :picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')}, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    put :update, {:id => @picture.to_param, :picture => @picture.attributes, :profile_id => profiles(:one).nick}
    assert_response 200 # picture wasn't updated b/c there's no image in the fixture / put request

    put :update, {:id => @picture.to_param, :picture => {:photo => fixture_file_upload('sample_photo.jpg', 'image/jpeg')}, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to profile_picture_path(profiles(:one), assigns(:picture))
  end

  test "should destroy picture" do
    delete :destroy, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

    assert_difference('Picture.count', -1) do
      delete :destroy, {:id => @picture.to_param, :profile_id => profiles(:one).nick}
    end

    assert_redirected_to profile_pictures_path(profiles(:one))
  end

  test "should create comment" do
    post :create_comment, {:id => @picture.to_param, :profile_id => profiles(:one).nick, :comment => "Wow, that's nice!"}
    assert_response 302
    assert_redirected_to new_user_session_path

    sign_in :user, users(:one)

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
