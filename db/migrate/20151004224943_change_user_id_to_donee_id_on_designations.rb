class ChangeUserIdToDoneeIdOnDesignations < ActiveRecord::Migration
  def change
    rename_column :designations, :user_id, :donee_id
  end
end
