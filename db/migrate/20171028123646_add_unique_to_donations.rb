class AddUniqueToDonations < ActiveRecord::Migration
  def change
    add_index :donations, :pledge_id, unique: true
  end
end
