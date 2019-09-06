class AddPropertyToPropertyImage < ActiveRecord::Migration
  def change
    add_column :property_images, :property_id, :integer
  end
end
