class AddDoneeStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :donee_state, :integer, default: 0
  end
end
