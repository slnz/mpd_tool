class AddGiftTypeToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :gift_type, :integer, default: 0
  end
end
