class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.decimal :amount
      t.string :first_name
      t.string :last_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.integer :status, default: 0
      t.integer :giving_method, default: 0
      t.integer :designation_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
