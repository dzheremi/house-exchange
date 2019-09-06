require 'test_helper'

class ListingTest < ActiveSupport::TestCase
    test "get listing" do
        listing = listings(:one)
        assert listing
    end

    test "create listing" do 
      property = properties(:one)
      user = users(:one)
      listing = Listing.new
      listing.property = property
      listing.start = "2016-01-01"
      listing.end = "2016-02-01"
      listing.daily_points = 80
      listing.active = true
      listing.user = user
      assert listing.save
    end

    test "update listing" do
      listing = listings(:one)
      listing.notes = "A test note."
      assert listing.save
      assert_equal listing.notes, "A test note."
    end

    test "delete listing" do
      listing = listings(:one)
      assert listing.delete
    end

end
