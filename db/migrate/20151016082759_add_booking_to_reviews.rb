class AddBookingToReviews < ActiveRecord::Migration
  def change
    add_column :user_reviews, :booking_id, :integer
    add_column :property_reviews, :booking_id, :integer
  end
end
