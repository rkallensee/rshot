class Picture < ActiveRecord::Base
  belongs_to :album
  
  # validation
  validates :title, :presence => true, :length => { :minimum => 3 }
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes  

  # Paperclip attachment
  has_attached_file :photo,
    :styles => {
      :thumb   => ["75x75#", :jpg],
      :small   => ["230x230>", :jpg],
      :medium  => ["640x640>", :jpg] }
      
  # named scopes
  named_scope :same_album, lambda { |att| {:conditions => ["album_id = ?", att]} }
  named_scope :next,       lambda { |att| {:conditions => ["id > ?", att], :limit => 1, :order => "id"} }
  named_scope :previous,   lambda { |att| {:conditions => ["id < ?", att], :limit => 1, :order => "id DESC"} }
      
  def album_name
    unless album.nil?
      album.title
    end
  end
end
