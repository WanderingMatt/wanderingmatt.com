class CreateImagesTable < ActiveRecord::Migration
  def self.up
    create_table "images", :force => true do |t|
      t.string :title, :path, :name
      t.text :source_url
      t.timestamps
    end
  end

  def self.down
    drop_table 'images'
  end
end
