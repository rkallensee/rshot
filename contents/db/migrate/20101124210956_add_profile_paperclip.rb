class AddProfilePaperclip < ActiveRecord::Migration
  def self.up
    add_column :profiles, :avatar_file_name, :string # Original filename
    add_column :profiles, :avatar_content_type, :string # Mime type
    add_column :profiles, :avatar_file_size, :integer # File size in bytes
  end

  def self.down
    remove_column :profiles, :avatar_file_name
    remove_column :profiles, :avatar_content_type
    remove_column :profiles, :avatar_file_size
  end
end
