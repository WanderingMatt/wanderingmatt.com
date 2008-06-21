class AddCachedAtToFeeds < ActiveRecord::Migration
  def self.up
    add_column 'feeds', 'cached_at', :datetime
  end

  def self.down
    remove_column 'feeds', 'cached_at'
  end
end