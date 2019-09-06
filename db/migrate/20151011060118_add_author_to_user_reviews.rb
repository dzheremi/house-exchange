class AddAuthorToUserReviews < ActiveRecord::Migration
  def change
    add_column :user_reviews, :author, :integer
  end
end
