# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111026195145) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["profile_id"], :name => "index_comments_on_profile_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "picture_metadata", :force => true do |t|
    t.integer  "picture_id"
    t.string   "make"
    t.string   "model"
    t.string   "lens"
    t.datetime "date_time"
    t.datetime "date_time_original"
    t.datetime "date_time_digitized"
    t.string   "exposure_time"
    t.float    "focal_length"
    t.float    "focal_length_in_35mm_film"
    t.float    "aperture"
    t.integer  "iso"
    t.float    "exposure_bias_value"
    t.integer  "white_balance"
    t.integer  "exposure_program"
    t.integer  "flash"
    t.integer  "width"
    t.integer  "height"
    t.string   "software"
    t.integer  "exposure_mode"
    t.integer  "metering_mode"
    t.integer  "orientation"
    t.string   "artist"
    t.string   "copyright"
    t.string   "description"
    t.text     "user_comment"
    t.string   "brightness_value"
    t.float    "max_aperture_value"
    t.string   "subject_distance"
    t.integer  "light_source"
    t.float    "flash_energy"
    t.float    "gps_latitude"
    t.float    "gps_longitude"
    t.float    "gps_altitude"
    t.float    "gps_direction"
    t.text     "exifraw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "picture_metadata", ["picture_id"], :name => "index_picture_metadata_on_picture_id"

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.integer  "album_id"
    t.integer  "profile_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "nick"
    t.string   "forename"
    t.string   "surname"
    t.string   "bio"
    t.string   "location"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.integer  "user_id"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
