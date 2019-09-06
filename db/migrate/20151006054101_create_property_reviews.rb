class CreatePropertyReviews < ActiveRecord::Migration
  def change
    create_table :property_reviews do |t|
      t.integer :property_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
