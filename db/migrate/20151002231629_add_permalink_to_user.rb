class AddPermalinkToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :permalink, :string
    add_index :users, :permalink
  end
  def self.down
    remove_column :users, :permalink
  end
end