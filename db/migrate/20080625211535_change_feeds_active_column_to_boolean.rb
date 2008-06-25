class ChangeFeedsActiveColumnToBoolean < ActiveRecord::Migration
  def self.up
    change_column 'feeds', 'active', :boolean, :default => 0
  end

  def self.down
    change_column 'feeds', 'active', :integer, :default => null
  end
end
