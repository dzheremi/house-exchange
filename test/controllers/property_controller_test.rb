require 'test_helper'

class PropertyControllerTest < ActionController::TestCase
  test "should get view of new property" do
    user = users(:one)
    session[:current_user] = user.id
    get :new
    assert_response :success
  end

  test "should not get view of new property" do
    get :new
    assert_response :redirect
  end

  test "should save new property" do
    user = users(:one)
    session[:current_user] = user.id
    property = properties(:one)
    property.title = "A new unique title!"
    post :save, property: {title: property.title, address_1: property.address_1, address_2: property.address_2, suburb: property.suburb, state: property.state, post_code: property.post_code, description: property.description}
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not save new property title not unique" do
    user = users(:one)
    session[:current_user] = user.id
    property = properties(:one)
    post :save, property: {title: property.title, address_1: property.address_1, address_2: property.address_2, suburb: property.suburb, state: property.state, post_code: property.post_code, description: property.description}
    assert_not_equal flash[:error], nil
    assert_response :success
  end

  test "should not save new property not logged in" do
    property = properties(:one)
    property.title = "A new unique title!"
    post :save, property: {title: property.title, address_1: property.address_1, address_2: property.address_2, suburb: property.suburb, state: property.state, post_code: property.post_code, description: property.description}
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should list properties" do
    user = users(:one)
    session[:current_user] = user.id
    get :list
    assert_response :success
  end

  test "should not list properties" do
    get :list
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should edit property" do
    user = users(:one)
    session[:current_user] = user.id
    property = properties(:one)
    get :edit, id: property.id
    assert_response :success
  end

  test "should not edit property not owner" do
    user = users(:two)
    session[:current_user] = user.id
    property = properties(:one)
    get :edit, id: property.id
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not edit property not logged in" do
    property = properties(:one)
    get :edit, id: property.id
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should update property" do
    user = users(:one)
    session[:current_user] = user.id
    property = properties(:one)
    post :update, id: property.id, property: {title: property.title, address_1: property.address_1, address_2: property.address_2, suburb: property.suburb, state: property.state, post_code: property.post_code, description: property.description}
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not update property not owner" do
    user = users(:two)
    session[:current_user] = user.id
    property = properties(:one)
    post :update, id: property.id, property: {title: property.title, address_1: property.address_1, address_2: property.address_2, suburb: property.suburb, state: property.state, post_code: property.post_code, description: property.description}
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not update property not logged in" do
    property = properties(:one)
    post :update, id: property.id, property: {title: property.title, address_1: property.address_1, address_2: property.address_2, suburb: property.suburb, state: property.state, post_code: property.post_code, description: property.description}
    assert_redirected_to(controller: "authentication", action: "login")
  end

  test "should delete property" do
    user = users(:one)
    session[:current_user] = user.id
    property = properties(:one)
    post :delete, id: property.id
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not delete property not owner" do
    user = users(:two)
    session[:current_user] = user.id
    property = properties(:one)
    post :delete, id: property.id
    assert_not_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not delete property not logged in" do
    property = properties(:one)
    post :delete, id: property.id
    assert_redirected_to(controller: "authentication", action: "login")
  end

end
