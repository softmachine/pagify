require 'test_helper'

class Pagify::CategorizationsControllerTest < ActionController::TestCase
  setup do
    @pagify_categorization = pagify_categorizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagify_categorizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagify_categorization" do
    assert_difference('Pagify::Categorization.count') do
      post :create, pagify_categorization: @pagify_categorization.attributes
    end

    assert_redirected_to pagify_categorization_path(assigns(:pagify_categorization))
  end

  test "should show pagify_categorization" do
    get :show, id: @pagify_categorization.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pagify_categorization.to_param
    assert_response :success
  end

  test "should update pagify_categorization" do
    put :update, id: @pagify_categorization.to_param, pagify_categorization: @pagify_categorization.attributes
    assert_redirected_to pagify_categorization_path(assigns(:pagify_categorization))
  end

  test "should destroy pagify_categorization" do
    assert_difference('Pagify::Categorization.count', -1) do
      delete :destroy, id: @pagify_categorization.to_param
    end

    assert_redirected_to pagify_categorizations_path
  end
end
