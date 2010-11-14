class Picture < ActiveRecord::Base
  # Paperclip attachment
  has_attached_file :photo,
    :styles => {
      :thumb=> ["75x75#", :jpg],
      :small  => ["230x230>", :jpg] }
end
