class AddCampusToDesignation < ActiveRecord::Migration
  def change
    add_column :designations, :campus_id, :integer
  end
end
