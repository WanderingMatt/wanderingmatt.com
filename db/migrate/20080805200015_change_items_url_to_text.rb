class ChangeItemsUrlToText < ActiveRecord::Migration
  def self.up
    change_column 'items', 'url', :text
  end

  def self.down
    change_column 'items', 'url', :string
  end
end
