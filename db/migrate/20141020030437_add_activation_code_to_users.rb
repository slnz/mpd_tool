class AddActivationCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_code, :string
  end
end
