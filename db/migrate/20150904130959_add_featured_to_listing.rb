class AddFeaturedToListing < ActiveRecord::Migration
  def change
    change_table :listings do |t|
      t.boolean :featured
    end
  end
end
