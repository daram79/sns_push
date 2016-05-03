require 'test_helper'

class UserPushKeysControllerTest < ActionController::TestCase
  setup do
    @user_push_key = user_push_keys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_push_keys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_push_key" do
    assert_difference('UserPushKey.count') do
      post :create, user_push_key: {  }
    end

    assert_redirected_to user_push_key_path(assigns(:user_push_key))
  end

  test "should show user_push_key" do
    get :show, id: @user_push_key
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_push_key
    assert_response :success
  end

  test "should update user_push_key" do
    patch :update, id: @user_push_key, user_push_key: {  }
    assert_redirected_to user_push_key_path(assigns(:user_push_key))
  end

  test "should destroy user_push_key" do
    assert_difference('UserPushKey.count', -1) do
      delete :destroy, id: @user_push_key
    end

    assert_redirected_to user_push_keys_path
  end
end
