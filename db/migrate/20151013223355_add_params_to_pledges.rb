class AddParamsToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :params, :text
  end
end
