class AddProjectIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :project_id, :integer
  end
end
