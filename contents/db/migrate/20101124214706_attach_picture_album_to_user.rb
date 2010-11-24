class AttachPictureAlbumToUser < ActiveRecord::Migration
  def self.up
    add_column :pictures, :user_id, :integer
    add_column :albums, :user_id, :integer
  end

  def self.down
    remove_column :pictures, :user_id
    remove_column :albums, :user_id
  end
end
