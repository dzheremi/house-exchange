class AddTenantToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :tenant_id, :integer
  end
end
