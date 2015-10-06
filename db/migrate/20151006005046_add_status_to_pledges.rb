class AddStatusToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :status, :integer, default: 0
  end
end
