class AddPayloadToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :payload, :text
  end
end
