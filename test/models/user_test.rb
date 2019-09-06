require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "get user" do
    user = users(:one)
    assert user
  end

  test "create user" do
    user = User.new
    user.email_address = "test@example.com"
    user.email_address_confirmation = user.email_address
    user.password = "password"
    user.password_confirmation = user.password
    user.first_name = "Test"
    user.last_name = "User"
    user.address_1 = "123 Test Street"
    user.suburb = "Testville"
    user.state = "VIC"
    user.post_code = "3000"
    user.phone = "123456789"
    assert user.save
  end

  test "update user" do
    user = users(:one)
    user.email_address_confirmation = user.email_address
    user.password_confirmation = user.password
    user.first_name = "Changed Name"
    assert user.save
    assert_equal user.first_name, "Changed Name"
  end

  test "delete user" do
    user = users(:one)
    assert user.delete
  end

end
