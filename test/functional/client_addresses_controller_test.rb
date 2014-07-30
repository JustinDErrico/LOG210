require 'test_helper'

class ClientAddressesControllerTest < ActionController::TestCase
  setup do
    @client_address = client_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_address" do
    assert_difference('ClientAddress.count') do
      post :create, client_address: { address: @client_address.address, client_id: @client_address.client_id }
    end

    assert_redirected_to client_address_path(assigns(:client_address))
  end

  test "should show client_address" do
    get :show, id: @client_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_address
    assert_response :success
  end

  test "should update client_address" do
    put :update, id: @client_address, client_address: { address: @client_address.address, client_id: @client_address.client_id }
    assert_redirected_to client_address_path(assigns(:client_address))
  end

  test "should destroy client_address" do
    assert_difference('ClientAddress.count', -1) do
      delete :destroy, id: @client_address
    end

    assert_redirected_to client_addresses_path
  end
end
