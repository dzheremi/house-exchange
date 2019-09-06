class AddReviewToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :tenant_reviewed, :boolean
    add_column :bookings, :tenant_reviewed_at, :datetime
    add_column :bookings, :owner_reviewed, :boolean
    add_column :bookings, :owner_reviewed_at, :datetime
  end
end
