class AddVisibleToFeeds < ActiveRecord::Migration
  def self.up
    add_column 'feeds', 'visible', :boolean
  end

  def self.down
    remove_column 'feeds', 'visible'
  end
end
