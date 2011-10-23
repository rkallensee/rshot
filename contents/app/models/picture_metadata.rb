class PictureMetadata < ActiveRecord::Base
  belongs_to :picture

  validates_presence_of :picture_id

  #serialize :exifraw
end
