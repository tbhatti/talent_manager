class AddRoleUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string
  end

  def down
  end
end
