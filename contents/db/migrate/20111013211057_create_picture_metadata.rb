class CreatePictureMetadata < ActiveRecord::Migration
  def up
    create_table :picture_metadata do |t|
      t.integer :picture_id # has_one relationship

      t.string :make
      t.string :model
      t.string :lens
      t.datetime :date_time
      t.datetime :date_time_original
      t.datetime :date_time_digitized
      t.string :exposure_time
      t.float :focal_length
      t.float :focal_length_in_35mm_film
      t.float :aperture
      t.integer :iso
      t.float :exposure_bias_value
      t.integer :white_balance
      t.integer :exposure_program
      t.integer :flash
      t.integer :width
      t.integer :height
      t.string :software
      t.integer :exposure_mode
      t.integer :metering_mode
      t.integer :orientation
      t.string :artist
      t.string :copyright
      t.string :description
      t.text :user_comment
      t.string :brightness_value
      t.float :max_aperture_value
      t.string :subject_distance
      t.integer :light_source
      t.float :flash_energy

      t.float :gps_latitude
      t.float :gps_longitude
      t.float :gps_altitude
      t.float :gps_direction

      t.text :exifraw

      t.timestamps
    end

    add_index :picture_metadata, :picture_id
  end

  def down
    drop_table :picture_metadata
  end
end
