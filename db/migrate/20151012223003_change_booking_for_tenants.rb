class ChangeBookingForTenants < ActiveRecord::Migration
  def change
    rename_column :bookings, :approved, :owner_approved
    rename_column :bookings, :approved_at, :owner_approved_at
    add_column :bookings, :tenant_approved, :boolean
    add_column :bookings, :tenant_approved_at, :datetime
  end
end
