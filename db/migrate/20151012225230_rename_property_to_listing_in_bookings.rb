class RenamePropertyToListingInBookings < ActiveRecord::Migration
  def change
    rename_column :bookings, :property_id, :listing_id
  end
end
