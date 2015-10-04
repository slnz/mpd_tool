class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :designation_id
      t.string :first_name
      t.string :last_name
      t.decimal :amount
      t.boolean :anonymous, default: false
      t.string :email
      t.string :phone
      t.string :organization
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.integer :method
      t.boolean :terms, default: false
      t.boolean :prayer_only, default: false
      t.boolean :newsletter, default: true
      t.timestamps null: false
    end
  end
end
