require 'test_helper'

class SnsPushKeysControllerTest < ActionController::TestCase
  setup do
    @sns_push_key = sns_push_keys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sns_push_keys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sns_push_key" do
    assert_difference('SnsPushKey.count') do
      post :create, sns_push_key: {  }
    end

    assert_redirected_to sns_push_key_path(assigns(:sns_push_key))
  end

  test "should show sns_push_key" do
    get :show, id: @sns_push_key
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sns_push_key
    assert_response :success
  end

  test "should update sns_push_key" do
    patch :update, id: @sns_push_key, sns_push_key: {  }
    assert_redirected_to sns_push_key_path(assigns(:sns_push_key))
  end

  test "should destroy sns_push_key" do
    assert_difference('SnsPushKey.count', -1) do
      delete :destroy, id: @sns_push_key
    end

    assert_redirected_to sns_push_keys_path
  end
end
