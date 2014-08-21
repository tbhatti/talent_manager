class AddRemoveColumnsUsers < ActiveRecord::Migration
  def up
    add_column :users ,:name, :string
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
  end
end
