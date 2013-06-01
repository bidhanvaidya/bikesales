require 'test_helper'

class BikeSpecsControllerTest < ActionController::TestCase
  setup do
    @bike_spec = bike_specs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bike_specs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike_spec" do
    assert_difference('BikeSpec.count') do
      post :create, bike_spec: { body: @bike_spec.body, make: @bike_spec.make, model: @bike_spec.model, variant: @bike_spec.variant }
    end

    assert_redirected_to bike_spec_path(assigns(:bike_spec))
  end

  test "should show bike_spec" do
    get :show, id: @bike_spec
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike_spec
    assert_response :success
  end

  test "should update bike_spec" do
    put :update, id: @bike_spec, bike_spec: { body: @bike_spec.body, make: @bike_spec.make, model: @bike_spec.model, variant: @bike_spec.variant }
    assert_redirected_to bike_spec_path(assigns(:bike_spec))
  end

  test "should destroy bike_spec" do
    assert_difference('BikeSpec.count', -1) do
      delete :destroy, id: @bike_spec
    end

    assert_redirected_to bike_specs_path
  end
end
