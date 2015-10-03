class AddProjectIdToDesignations < ActiveRecord::Migration
  def change
    add_column :designations, :project_id, :integer
  end
end
