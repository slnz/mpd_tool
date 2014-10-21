class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :designation_code
      t.string :activation_code
      t.boolean :email_sent, default: false
      t.integer :user_id
      t.timestamps
    end
    add_index :designations, :activation_code, unique: true
  end
end
