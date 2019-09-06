require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should process login" do
    user = users(:one)
    post :process_login, user: {email_address: user.email_address, password: user.password}
    assert_equal user.id, session[:current_user]
    assert_response :redirect
  end

  test "show not process login" do
    user = users(:two)
    post :process_login, user: {email_address: user.email_address, password: 'ABadPass'}
    assert_not_equal user.id, session[:current_user]
    assert_response :redirect
  end

  test "should get logout" do
    user = users(:one)
    post :process_login, user: {email_address: user.email_address, password: user.password}
    get :logout
    assert_equal session[:current_user], nil
    assert_response :redirect
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should create user" do
    user = users(:one)
    user.email_address = "unique@email.com"
    post :create_user, user: {email_address: user.email_address, email_address_confirmation: user.email_address, password: user.password, password_confirmation: user.password, first_name: user.first_name, last_name: user.last_name, address_1: user.address_1, address_2: user.address_2, suburb: user.suburb, state: user.state, post_code: user.post_code, phone: user.phone}
    assert_equal flash[:error], nil
    assert_response :redirect
  end

  test "should not create user not unique email" do
    user = users(:one)
    post :create_user, user: {email_address: user.email_address, email_address_confirmation: user.email_address, password: user.password, password_confirmation: user.password, first_name: user.first_name, last_name: user.last_name, address_1: user.address_1, address_2: user.address_2, suburb: user.suburb, state: user.state, post_code: user.post_code, phone: user.phone}
    assert_not_equal flash[:error], nil
    assert_response :success
  end

  test "should not create user passwords do not match" do
    user = users(:one)
    post :create_user, user: {email_address: user.email_address, email_address_confirmation: user.email_address, password: user.password, password_confirmation: "AnotherPassword", first_name: user.first_name, last_name: user.last_name, address_1: user.address_1, address_2: user.address_2, suburb: user.suburb, state: user.state, post_code: user.post_code, phone: user.phone}
    assert_not_equal flash[:error], nil
    assert_response :success
  end

end
