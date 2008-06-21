class Item < ActiveRecord::Base
  
  require 'time'
  
  def self.prepare_and_save(feed, item)
    
    data = { 'feed_id' => feed.id } and item.elements.each do |e|
      data[e.name.gsub(/^dc:(\\w)/,"\\1").to_s] = e.text
    end
    
    new_item = format_data(data)
    
    # puts data.to_yaml
    puts new_item.to_yaml
    
  end
  
  
  def self.format_data(data)
    new_item = {}
    
    published_at = data['date'] || data['pubDate']
    
    new_item['feed_id'] = data['feed_id']
    new_item['title'] = data['title']
    new_item['description'] = data['description']
    new_item['url'] = data['link']
    new_item['tags'] = data['subject']
    new_item['published_at'] = Time.parse(published_at.to_s).to_s(:db);
    new_item['published_at_raw'] = published_at.to_s;
    new_item['cached_at'] = Time.zone.now.to_s(:db);
    new_item
  end
  
end