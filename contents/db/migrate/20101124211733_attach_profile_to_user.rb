class AttachProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :profiles, :user_id, :integer # has_one relationship
    
    remove_column :users, :nick
    remove_column :users, :forename
    remove_column :users, :surname
    remove_column :users, :bio
    remove_column :users, :location
    remove_column :users, :website
  end

  def self.down
    remove_column :profiles, :user_id
    
    add_column :users, :nick, :string
    add_column :users, :forename, :string
    add_column :users, :surname, :string
    add_column :users, :bio, :string
    add_column :users, :location, :string
    add_column :users, :website, :string
  end
end
