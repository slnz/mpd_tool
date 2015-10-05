class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :organization, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :city, :string
    add_column :users, :postcode, :string
    add_column :users, :donor_state, :integer
    add_column :users, :terms, :boolean, default: false
  end
end
