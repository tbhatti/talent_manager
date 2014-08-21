class AddUseridAddress < ActiveRecord::Migration
  def up
    add_column :addresses, :user_id, :integer
  end

  def down
  end
end
