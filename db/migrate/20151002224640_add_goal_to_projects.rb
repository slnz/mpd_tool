class AddGoalToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :goal, :decimal
  end
end
