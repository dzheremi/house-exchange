class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :property_id
      t.date :start
      t.date :end
      t.integer :daily_points
      t.boolean :active
      t.text :notes

      t.timestamps
    end
  end
end
