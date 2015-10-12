class AddDonationIdToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :donation_id, :integer
  end
end
