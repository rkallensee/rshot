class ExtractAndStorePictureMetadata < ActiveRecord::Migration
  def up
    Picture.all.each do |picture|
      picture.extract_and_save_metadata!
    end
  end

  def down
    # nothing to do here.
  end
end
