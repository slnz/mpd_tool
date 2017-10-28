class AddBelongsToPledgeToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :pledge_id, :integer
    Pledge.find_each do |pledge|
      next unless pledge.donation_id
      donation = Donation.find_by(id: pledge.donation_id)
      donation.update(pledge_id: pledge.id) if donation
    end
    remove_column :pledges, :donation_id, :integer
  end
end
