class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email_address
      t.text :password
      t.text :first_name
      t.text :last_name
      t.text :address_1
      t.text :address_2
      t.text :suburb
      t.text :state
      t.text :post_code
      t.text :phone

      t.timestamps
    end
  end
end
