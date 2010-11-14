class Picture < ActiveRecord::Base
  belongs_to :album
  
  # validation
  validates :title, :presence => true,
                    :length => { :minimum => 3 }
  validates_attachment_presence :photo

  # Paperclip attachment
  has_attached_file :photo,
    :styles => {
      :thumb=> ["75x75#", :jpg],
      :small  => ["230x230>", :jpg] }
      
  def album_name
    unless album.nil?
      album.title
    end
  end
end
