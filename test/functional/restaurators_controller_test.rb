require 'test_helper'

class RestauratorsControllerTest < ActionController::TestCase
  setup do
    @restaurator = restaurators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create restaurator" do
    assert_difference('Restaurator.count') do
      post :create, restaurator: {  }
    end

    assert_redirected_to restaurator_path(assigns(:restaurator))
  end

  test "should show restaurator" do
    get :show, id: @restaurator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @restaurator
    assert_response :success
  end

  test "should update restaurator" do
    put :update, id: @restaurator, restaurator: {  }
    assert_redirected_to restaurator_path(assigns(:restaurator))
  end

  test "should destroy restaurator" do
    assert_difference('Restaurator.count', -1) do
      delete :destroy, id: @restaurator
    end

    assert_redirected_to restaurators_path
  end
end
