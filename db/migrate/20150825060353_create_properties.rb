class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.text :title
      t.text :address_1
      t.text :address_2
      t.text :suburb
      t.text :state
      t.text :post_code
      t.text :description

      t.timestamps
    end
  end
end
