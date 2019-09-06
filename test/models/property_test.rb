require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  test "get property" do
    property = properties(:one)
    assert property
  end

  test "create property" do
    user = users(:one)
    property = Property.new
    property.title = "A Test Property"
    property.address_1 = "123 Fake Street"
    property.suburb = "Fake Suburb"
    property.state = "VIC"
    property.post_code = "3000"
    property.description = "This is a fake property."
    property.user = user
    assert property.save
  end

  test "update property" do
    property = properties(:one)
    property.title = "A Changed Title"
    assert property.save
    assert_equal property.title, "A Changed Title"
  end

  test "delete property" do
    property = properties(:one)
    assert property.delete
  end

end
