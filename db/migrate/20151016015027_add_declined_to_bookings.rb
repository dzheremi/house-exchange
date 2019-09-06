class AddDeclinedToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :owner_declined, :boolean
    add_column :bookings, :owner_declined_at, :datetime
    add_column :bookings, :tenant_declined, :boolean
    add_column :bookings, :tenant_declined_at, :datetime
  end
end
