class AddPointCostToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :point_cost, :integer
  end
end
