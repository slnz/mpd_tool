class RemovePermalinkAndAddSlugToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :permalink, :string
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end
end
