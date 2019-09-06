class CreatePropertyFeatures < ActiveRecord::Migration
  def change
    create_table :property_features do |t|
      t.text :name

      t.timestamps
    end
  end
end
