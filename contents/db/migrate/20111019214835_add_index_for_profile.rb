class AddIndexForProfile < ActiveRecord::Migration
  def up
    add_index :profiles, :user_id
  end

  def down
    remove_index :profiles, :user_id
  end
end
