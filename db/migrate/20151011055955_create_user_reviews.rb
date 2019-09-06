class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
