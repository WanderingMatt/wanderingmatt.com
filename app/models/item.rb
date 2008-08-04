class Item < ActiveRecord::Base
  
  belongs_to :feed
  
  def prepare_and_save(feed, xml_data)
    self.feed_id = feed.id
    self.cached_at = feed.cached_at
    
    format_data(xml_data, feed.permalink)
    
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
      !item.blank?
    end
  end
  
  def format_data(xml_data, permalink)
    @data = xml_data
    method_name = "format_#{permalink}_data"
    self.send(method_name) if self.respond_to?(method_name)
  end
  
  
  def format_lastfm_data
    self.title = (@data/:name).inner_html
    self.description = (@data/:artist).inner_html
    self.url = (@data/:url).inner_html
    self.tags = (@data/:album).inner_html
    self.published_at = Time.parse((@data/:date).inner_html)
  end
  
  # def prepare_and_save(feed, xml_data)
  #     self.feed_id = feed.id
  #     self.cached_at = feed.cached_at
  #     
  #     @data = prepare_data(xml_data)
  #     format_data(feed.permalink)
  #     
  #     unless cached?
  #       save!
  #       self
  #     else
  #       false
  #     end
  #   end
  # 
  # def cached?
  #   if self.feed_id && self.published_at
  #     item = Item.find(:first, :conditions => { :published_at => self.published_at, :feed_id => self.feed_id })
  #     !item.blank?
  #   end
  # end
  # 
  # def prepare_data(xml_data)
  #   data = {} and xml_data.elements.each do |e|
  #     data[e.name.gsub(/^dc:(\\w)/,"\\1").to_s] = e.text || e.attributes['url']
  #   end
  #   data
  # end
  # 
  # def format_data(permalink)
  #   self.title = @data['title']
  #   self.description = @data['description']
  #   self.url = @data['link']
  #   self.tags = @data['subject'] || @data['category']
  #   
  #   published_at = @data['date'] || @data['pubDate']
  #   self.published_at = Time.parse(published_at.to_s);
  #   
  #   method_name = "format_#{permalink}_data"
  #   self.send(method_name) if self.respond_to?(method_name)
  # end
  # 
  # def format_flickr_data
  #   puts @data.to_yaml
  # end
  
end