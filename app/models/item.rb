class Item < ActiveRecord::Base
  
  belongs_to :feed
  
  def prepare_and_save(feed, xml_data)
    self.feed_id = feed.id
    self.cached_at = feed.cached_at
    
    prepare_data(xml_data)
    format_data
    
    unless cached?
      save!
      self
    else
      false
    end
  end
  
  def cached?
    if self.feed_id && self.published_at
      item = Item.find(:first, :conditions => { :published_at => self.published_at, :feed_id => self.feed_id })
      if item
        true
      else
        false
      end
    end
  end
  
  def prepare_data(xml_data)
    data = {} and xml_data.elements.each do |e|
      data[e.name.gsub(/^dc:(\\w)/,"\\1").to_s] = e.text
    end
    @data = data
  end
  
  def format_data
    self.title = @data['title']
    self.description = @data['description']
    self.url = @data['link']
    self.tags = @data['subject']
    
    published_at = @data['date'] || @data['pubDate']
    self.published_at = Time.parse(published_at.to_s);
  end
  
end