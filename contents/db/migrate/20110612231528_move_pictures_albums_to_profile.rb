class MovePicturesAlbumsToProfile < ActiveRecord::Migration
  def up
    rename_column :pictures, :user_id, :profile_id
    rename_column :albums, :user_id, :profile_id
  end

  def down
    rename_column :pictures, :profile_id, :user_id
    rename_column :albums, :profile_id, :user_id
  end
end
