class AddSourceImageUrlToImagesTable < ActiveRecord::Migration
  def self.up
    add_column 'images', 'source_image_url', :text
  end

  def self.down
    remove_column 'images', 'source_image_url'
  end
end
