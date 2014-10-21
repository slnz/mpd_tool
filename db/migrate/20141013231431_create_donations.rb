class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :global_id
      t.integer :contact_id
      t.integer :designation_id
      t.string :payment_method
      t.date :display_date
      t.decimal :amount

      t.timestamps
    end
  end
end
