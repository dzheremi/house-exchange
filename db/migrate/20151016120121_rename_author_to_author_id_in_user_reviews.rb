class RenameAuthorToAuthorIdInUserReviews < ActiveRecord::Migration
  def change
    rename_column :user_reviews, :author, :author_id
  end
end
