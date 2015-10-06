class RemovePrayerOnlyFromPledges < ActiveRecord::Migration
  def change
    remove_column :pledges, :prayer_only, :boolean
  end
end
