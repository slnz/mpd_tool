class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.integer :code
      t.integer :designation_code
      t.timestamps
    end
  end
end
