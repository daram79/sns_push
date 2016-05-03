require 'test_helper'

class SnsControllerTest < ActionController::TestCase
  setup do
    @sn = sns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sn" do
    assert_difference('Sn.count') do
      post :create, sn: {  }
    end

    assert_redirected_to sn_path(assigns(:sn))
  end

  test "should show sn" do
    get :show, id: @sn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sn
    assert_response :success
  end

  test "should update sn" do
    patch :update, id: @sn, sn: {  }
    assert_redirected_to sn_path(assigns(:sn))
  end

  test "should destroy sn" do
    assert_difference('Sn.count', -1) do
      delete :destroy, id: @sn
    end

    assert_redirected_to sns_path
  end
end
