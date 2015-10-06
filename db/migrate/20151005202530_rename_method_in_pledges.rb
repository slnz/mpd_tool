class RenameMethodInPledges < ActiveRecord::Migration
  def change
    rename_column :pledges, :method, :giving_method
  end
end
