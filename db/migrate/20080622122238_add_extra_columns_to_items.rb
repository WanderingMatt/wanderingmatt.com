class AddExtraColumnsToItems < ActiveRecord::Migration
  def self.up
    add_column 'items', 'description', :text
    add_column 'items', 'tags', :string
    add_column 'items', 'published_at', :datetime
    add_column 'items', 'cached_at', :datetime
  end

  def self.down
    remove_column 'items', 'description'
    remove_column 'items', 'tags'
    remove_column 'items', 'published_at'
    remove_column 'items', 'cached_at'
  end
end
