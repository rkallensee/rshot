class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :nick
      t.string :forename
      t.string :surname
      t.string :bio
      t.string :location
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
