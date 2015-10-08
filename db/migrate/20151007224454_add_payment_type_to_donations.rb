class AddPaymentTypeToDonations < ActiveRecord::Migration
  def up
    add_column :donations, :payment_type, :integer, default: 0
    Donation.all.each do |donation|
      donation.update_column(:payment_type, Donation.payment_types[donation.payment_method])
    end
    remove_column :donations, :payment_method
  end
end
