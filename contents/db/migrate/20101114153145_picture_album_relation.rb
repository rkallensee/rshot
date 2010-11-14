class PictureAlbumRelation < ActiveRecord::Migration
  def self.up
    add_column :pictures, :album_id, :integer # album relation
  end

  def self.down
    remove_column :pictures, :album_id
  end
end
