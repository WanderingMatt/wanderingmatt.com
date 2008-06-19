class Item < ActiveRecord::Base
  
  def self.prepare_and_save(feed, item)
    true
  end
  
end