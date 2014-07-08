require 'test_helper'

class PlatsControllerTest < ActionController::TestCase
  setup do
    @plat = plats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plat" do
    assert_difference('Plat.count') do
      post :create, plat: { description: @plat.description, menu_id: @plat.menu_id, nom: @plat.nom, prix: @plat.prix }
    end

    assert_redirected_to plat_path(assigns(:plat))
  end

  test "should show plat" do
    get :show, id: @plat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plat
    assert_response :success
  end

  test "should update plat" do
    put :update, id: @plat, plat: { description: @plat.description, menu_id: @plat.menu_id, nom: @plat.nom, prix: @plat.prix }
    assert_redirected_to plat_path(assigns(:plat))
  end

  test "should destroy plat" do
    assert_difference('Plat.count', -1) do
      delete :destroy, id: @plat
    end

    assert_redirected_to plats_path
  end
end
