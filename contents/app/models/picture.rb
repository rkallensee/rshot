class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :profile

  acts_as_commentable

  # Paperclip attachment
  has_attached_file :photo,
    :styles => {
      :thumb   => ["75x75#", :jpg],
      :small   => ["230x230>", :jpg],
      :medium  => ["640x640>", :jpg] },
    :convert_options => { :all => '-auto-orient' }

  # validation
  validates :title, :presence => true, :length => { :minimum => 3 }
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes

  # scopes
  scope :same_album, lambda { |att| {:conditions => ["album_id = ?", att]} }
  scope :next,       lambda { |att| {:conditions => ["id > ?", att], :limit => 1, :order => "id"} }
  scope :previous,   lambda { |att| {:conditions => ["id < ?", att], :limit => 1, :order => "id DESC"} }

  def album_name
    unless album.nil?
      album.title
    end
  end

  def self.random
    offset = rand(self.count)
    rand_record = self.first(:offset => offset)
  end

  def gps
    imgexif = EXIFR::JPEG.new(photo.path)
    #imgexif.gps if imgexif.gps?
    #[imgexif.gps_latitude, imgexif.gps_longitude]

    # https://github.com/picuous/exifr/blob/master/lib/jpeg.rb
    if !imgexif.exif? or imgexif.gps_latitude.nil? or imgexif.gps_latitude.length < 2 or imgexif.gps_longitude.nil? or imgexif.gps_longitude.length < 2
      nil
    else
      lat = imgexif.gps_latitude[0].to_f+imgexif.gps_latitude[1].to_f/60+imgexif.gps_latitude[2].to_f/3600
      lon = imgexif.gps_longitude[0].to_f+imgexif.gps_longitude[1].to_f/60+imgexif.gps_longitude[2].to_f/3600
      [lat, lon]
    end
  end

  def exifdetails
    imgexif = EXIFR::JPEG.new(photo.path)

    exifdata = {}

    if imgexif.exif?
        exifdata[:model] = imgexif.make + " " + imgexif.model
        exifdata[:date_time] = imgexif.date_time_original
        exifdata[:exposure_time] = imgexif.exposure_time.to_s
        exifdata[:focal_length] = imgexif.focal_length.to_i
        exifdata[:focal_length] = imgexif.focal_length_in_35mm_film.to_i unless imgexif.focal_length_in_35mm_film.nil?
        exifdata[:aperture] = imgexif.f_number.to_f
        exifdata[:iso] = imgexif.iso_speed_ratings
        exifdata[:width] = imgexif.width
        exifdata[:height] = imgexif.height
        exifdata[:date_time] = imgexif.date_time
        exifdata[:exif] = imgexif.exif # debug
    end

    exifdata
  end
end
