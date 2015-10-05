class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :designation_id
      t.decimal :amount
      t.integer :method
      t.boolean :anonymous, default: false
      t.boolean :prayer_only, default: false
      t.boolean :newsletter, default: true
      t.timestamps null: false
    end
  end
end
