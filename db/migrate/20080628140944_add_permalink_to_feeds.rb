class AddPermalinkToFeeds < ActiveRecord::Migration
  def self.up
    add_column 'feeds', 'permalink', :string
  end

  def self.down
    remove_column 'feeds', 'permalink'
  end
end
