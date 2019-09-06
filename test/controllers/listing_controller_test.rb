require 'test_helper'

class ListingControllerTest < ActionController::TestCase
  test "should get listings" do
    get :list
    assert_response :success
  end

  test "should get view of property" do
    listing = listings(:one)
    get :view, :id => listing.id 
    assert_response :success
  end

  test "should not get view of property not active" do
    listing = listings(:three)
    get :view, :id => listing.id
    assert_response :redirect
  end

  test "should get view of users listings" do
    user = users(:one)
    session[:current_user] = user.id
    get :user_listings
    assert_response :success 
  end

  test "should not get view of users listings" do
    get :user_listings
    assert_response :redirect
  end

  test "should get view of new listing" do
    user = users(:two)
    session[:current_user] = user.id
    get :new
    assert_response :success
  end

  test "should not get view of new listing" do
    get :new
    assert_response :redirect
  end

  test "should save new listing" do
    user = users(:one)
    session[:current_user] = user.id
    listing = listings(:one)
    post :save, listing: {property_id: listing.property_id, start: listing.start, end: listing.end, daily_points: listing.daily_points, active: listing.active, notes: listing.notes}
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not save new listing not owner" do
    user = users(:two)
    session[:current_user] = user.id
    listing = listings(:one)
    post :save, listing: {property_id: listing.property_id, start: listing.start, end: listing.end, daily_points: listing.daily_points, active: listing.active, notes: listing.notes}
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not save new listing not logged in" do
    listing = listings(:one)
    post :save, listing: {property_id: listing.property_id, start: listing.start, end: listing.end, daily_points: listing.daily_points, active: listing.active, notes: listing.notes}
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should edit existing listing" do
    user = users(:one)
    session[:current_user] = user.id
    listing = listings(:one)
    get :edit, id: listing.id
    assert_response :success
  end

  test "should not edit existing listing not owner" do
    user = users(:two)
    session[:current_user] = user.id
    listing = listings(:one)
    get :edit, id: listing.id
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not edit existing listing not logged in" do
    listing = listings(:one)
    get :edit, id: listing.id
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should update existing listing" do
    user = users(:one)
    session[:current_user] = user.id
    listing = listings(:one)
    post :update, id: listing.id, listing: {property_id: listing.property_id, start: listing.start, end: listing.end, daily_points: listing.daily_points, active: listing.active, notes: listing.notes}
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not update existing listing not owner" do
    user = users(:two)
    session[:current_user] = user.id
    listing = listings(:one)
    post :update, id: listing.id, listing: {property_id: listing.property_id, start: listing.start, end: listing.end, daily_points: listing.daily_points, active: listing.active, notes: listing.notes}
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not update existing listing not logged in" do
    listing = listings(:one)
    post :update, id: listing.id, listing: {property_id: listing.property_id, start: listing.start, end: listing.end, daily_points: listing.daily_points, active: listing.active, notes: listing.notes}
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should delete existing listing" do
    user = users(:one)
    session[:current_user] = user.id
    listing = listings(:one)
    post :delete, id: listing.id
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not delete existing listing not owner" do
    user = users(:two)
    session[:current_user] = user.id
    listing = listings(:one)
    post :delete, id: listing.id
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not delete existing listing not logged in" do
    listing = listings(:one)
    post :delete, id: listing.id
    assert_redirected_to(controller: "authentication", action: "login")
  end

end
