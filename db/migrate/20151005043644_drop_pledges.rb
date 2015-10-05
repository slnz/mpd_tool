class DropPledges < ActiveRecord::Migration
  def change
    drop_table :pledges
  end
end
