class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.integer :user_id
      t.date :start
      t.date :end
      t.integer :maximum_daily_points
      t.text :suburb

      t.timestamps
    end
  end
end
