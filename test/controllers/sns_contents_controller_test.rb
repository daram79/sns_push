require 'test_helper'

class SnsContentsControllerTest < ActionController::TestCase
  setup do
    @sns_content = sns_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sns_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sns_content" do
    assert_difference('SnsContent.count') do
      post :create, sns_content: {  }
    end

    assert_redirected_to sns_content_path(assigns(:sns_content))
  end

  test "should show sns_content" do
    get :show, id: @sns_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sns_content
    assert_response :success
  end

  test "should update sns_content" do
    patch :update, id: @sns_content, sns_content: {  }
    assert_redirected_to sns_content_path(assigns(:sns_content))
  end

  test "should destroy sns_content" do
    assert_difference('SnsContent.count', -1) do
      delete :destroy, id: @sns_content
    end

    assert_redirected_to sns_contents_path
  end
end
