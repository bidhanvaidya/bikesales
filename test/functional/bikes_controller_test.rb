require 'test_helper'

class BikesControllerTest < ActionController::TestCase
  setup do
    @bike = bikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bikes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike" do
    assert_difference('Bike.count') do
      post :create, bike: { address: @bike.address, body: @bike.body, color: @bike.color, comment: @bike.comment, engine_capacity: @bike.engine_capacity, make: @bike.make, model: @bike.model, odometer: @bike.odometer, phone: @bike.phone, price: @bike.price, reg_expiry: @bike.reg_expiry, rego_no: @bike.rego_no, type: @bike.type, variant: @bike.variant, vin_no: @bike.vin_no, year: @bike.year }
    end

    assert_redirected_to bike_path(assigns(:bike))
  end

  test "should show bike" do
    get :show, id: @bike
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike
    assert_response :success
  end

  test "should update bike" do
    put :update, id: @bike, bike: { address: @bike.address, body: @bike.body, color: @bike.color, comment: @bike.comment, engine_capacity: @bike.engine_capacity, make: @bike.make, model: @bike.model, odometer: @bike.odometer, phone: @bike.phone, price: @bike.price, reg_expiry: @bike.reg_expiry, rego_no: @bike.rego_no, type: @bike.type, variant: @bike.variant, vin_no: @bike.vin_no, year: @bike.year }
    assert_redirected_to bike_path(assigns(:bike))
  end

  test "should destroy bike" do
    assert_difference('Bike.count', -1) do
      delete :destroy, id: @bike
    end

    assert_redirected_to bikes_path
  end
end
