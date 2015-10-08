class RemoveDesignationCodeFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :designation_code, :string
  end
end
