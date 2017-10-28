class AddBelongsToPledgeToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :pledge_id, :integer
    Pledge.find_each do |p|
      Donation.find(p.donation_id).update(pledge_id: p.id) if p.donation_id
    end
    remove_column :pledges, :donation_id, :integer
  end
end
