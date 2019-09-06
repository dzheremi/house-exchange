class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :property_id
      t.date :start
      t.date :end
      t.boolean :approved
      t.datetime :approved_at

      t.timestamps
    end
  end
end
