class AddRatingToProperty < ActiveRecord::Migration
  def change
    add_column :property_reviews, :rating, :integer
  end
end
