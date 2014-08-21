class AddResumeColumnUsers < ActiveRecord::Migration
  def up
    add_column :users, :resume, :string
  end

  def down
  end
end
