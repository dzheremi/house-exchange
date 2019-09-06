class CreatePropertyImages < ActiveRecord::Migration
  def change
    create_table :property_images do |t|
      t.text :file_name
      t.integer :order

      t.timestamps
    end
  end
end
