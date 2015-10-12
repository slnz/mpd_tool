class AddContactIdToPledge < ActiveRecord::Migration
  def change
    add_column :pledges, :contact_id, :integer
  end
end
