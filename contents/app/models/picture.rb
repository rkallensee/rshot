class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :profile
  has_one :picture_metadata

  acts_as_taggable_on :tags
  acts_as_commentable

  # Paperclip attachment
  has_attached_file :photo,
    :styles => {
      :thumb   => ["75x75#", :jpg],
      :small   => ["250x250>", :jpg],
      :medium  => ["640x640>", :jpg] },
    :convert_options => { :all => '-auto-orient' }
  before_photo_post_process :extract_and_save_metadata!

  # validation
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes

  # scopes
  scope :same_album, lambda { |att| where("album_id = ?", att) }
  scope :next,       lambda { |att| where("id > ?", att).limit(1).order("id") }
  scope :previous,   lambda { |att| where("id < ?", att).limit(1).order("id DESC") }

  scope :by_profile, lambda { |att| where("profile_id = ?", att) }
  scope :by_album,   lambda { |att| where("album_id = ?", att) }

  def album_name
    unless album.nil?
      album.title
    end
  end

  def self.random
    offset = rand(self.count)
    rand_record = self.first(:offset => offset)
  end

  def metadata
    if picture_metadata.nil?
      build_picture_metadata
    end
    picture_metadata
  end

  def extract_and_save_metadata!
    if picture_metadata.nil?
      build_picture_metadata
    end

    begin
      unless photo.queued_for_write[:original].nil?
        # if called by "before_photo_post_process" event
        exifdata = EXIFR::JPEG.new(photo.queued_for_write[:original])
      else
        # if called manually, e.g. by migration
        exifdata = EXIFR::JPEG.new(photo.path)
      end
    rescue EXIFR::MalformedJPEG
      return false
    end

    if exifdata.exif?
      picture_metadata.make = exifdata.make unless exifdata.make.nil?

      unless exifdata.model.nil? && exifdata.make.nil?
        if exifdata.model.include? exifdata.make
          picture_metadata.model = exifdata.model
        else
          picture_metadata.model = exifdata.make + " " + exifdata.model
        end
      end

      # assign metadata to model if present
      #picture_metadata.lens = exifdata.lens unless exifdata.lens.nil? # TODO - tag currently not supported by EXIFR
      picture_metadata.date_time = exifdata.date_time unless exifdata.date_time.nil?
      picture_metadata.date_time_original = exifdata.date_time_original unless exifdata.date_time_original.nil?
      picture_metadata.date_time_digitized = exifdata.date_time_digitized unless exifdata.date_time_digitized.nil?
      picture_metadata.exposure_time = exifdata.exposure_time.to_s unless exifdata.exposure_time.nil?
      picture_metadata.focal_length = exifdata.focal_length.to_f unless exifdata.focal_length.nil?
      picture_metadata.focal_length_in_35mm_film = exifdata.focal_length_in_35mm_film.to_f unless exifdata.focal_length_in_35mm_film.nil?
      picture_metadata.aperture = exifdata.f_number.to_f unless exifdata.f_number.nil?
      picture_metadata.iso = exifdata.iso_speed_ratings.to_i unless exifdata.iso_speed_ratings.nil?
      picture_metadata.exposure_bias_value = exifdata.exposure_bias_value.to_f unless exifdata.exposure_bias_value.nil?
      picture_metadata.white_balance = exifdata.white_balance.to_i unless exifdata.white_balance.nil?
      picture_metadata.exposure_program = exifdata.exposure_program.to_i unless exifdata.exposure_program.nil?
      picture_metadata.flash = exifdata.flash.to_i unless exifdata.flash.nil?
      picture_metadata.width = exifdata.width.to_i unless exifdata.width.nil?
      picture_metadata.height = exifdata.height.to_i unless exifdata.height.nil?
      picture_metadata.software = exifdata.software.to_s unless exifdata.software.nil?
      picture_metadata.exposure_mode = exifdata.exposure_mode.to_i unless exifdata.exposure_mode.nil?
      picture_metadata.metering_mode = exifdata.metering_mode.to_i unless exifdata.metering_mode.nil?
      picture_metadata.orientation = exifdata.orientation.to_i unless exifdata.orientation.nil?
      picture_metadata.artist = exifdata.artist.to_s unless exifdata.artist.nil?
      picture_metadata.copyright = exifdata.copyright.to_s unless exifdata.copyright.nil?
      picture_metadata.description = exifdata.image_description.to_s unless exifdata.image_description.nil?
      picture_metadata.user_comment = exifdata.user_comment.to_s unless exifdata.user_comment.nil?
      picture_metadata.brightness_value = exifdata.brightness_value.to_s unless exifdata.brightness_value.nil?
      picture_metadata.exposure_bias_value = exifdata.exposure_bias_value.to_s unless exifdata.exposure_bias_value.nil?
      picture_metadata.max_aperture_value = exifdata.max_aperture_value.to_f unless exifdata.max_aperture_value.nil?
      picture_metadata.subject_distance = exifdata.subject_distance.to_s unless exifdata.subject_distance.nil?
      picture_metadata.light_source = exifdata.light_source.to_i unless exifdata.light_source.nil?
      picture_metadata.flash_energy = exifdata.flash_energy.to_f unless exifdata.flash_energy.nil?

      picture_metadata.gps_latitude = exifdata.gps.latitude unless exifdata.gps.nil?
      picture_metadata.gps_longitude = exifdata.gps.longitude unless exifdata.gps.nil?
      picture_metadata.gps_altitude = exifdata.gps.altitude unless exifdata.gps.nil?
      picture_metadata.gps_direction = exifdata.gps.image_direction unless exifdata.gps.nil?

      #picture_metadata.exifraw = exifdata.exif unless exifdata.exif.nil? # TODO - store plain serialized EXIF data

      picture_metadata.save
      return true
    end
  end

end
