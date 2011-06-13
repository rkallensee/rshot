class Profile < ActiveRecord::Base
  # Paperclip attachment
  has_attached_file :avatar,
    :styles => {
      :tiny   => ["48x48#", :jpg],
      :medium => ["75x75#", :jpg],
      :big    => ["120x120>", :jpg] }

  # relationship
  belongs_to :user
  has_many :pictures
  has_many :albums
end
