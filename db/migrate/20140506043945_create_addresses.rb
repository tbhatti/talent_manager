class CreateAddresses < ActiveRecord::Migration
  def up
    create_table :addresses do |t|

      t.string :industry , :null => false, :default => ""
      t.string :country , :null => false, :default => ""
      t.string :state , :null => false, :default => ""

    end

  end

  def down
    drop_table :addresses

  end
end
