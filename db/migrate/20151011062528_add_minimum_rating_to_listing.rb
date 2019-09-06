class AddMinimumRatingToListing < ActiveRecord::Migration
  def change
    add_column :listings, :minimum_rating, :integer
  end
end
