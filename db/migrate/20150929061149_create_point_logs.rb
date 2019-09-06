class CreatePointLogs < ActiveRecord::Migration
  def change
    create_table :point_logs do |t|
      t.integer :booking_id
      t.integer :user_id
      t.integer :points

      t.timestamps
    end
  end
end
