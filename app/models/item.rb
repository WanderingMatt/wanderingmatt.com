class Item < ActiveRecord::Base
  
  belongs_to :feed
  belongs_to :image
  
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
    if self.respond_to?(method_name)
      self.send(method_name)
    else
      format_feed_data
    end
  end
  
  def format_feed_data
    self.title = CGI.unescapeHTML((@data/:title).inner_html)
    self.description = CGI.unescapeHTML((@data/:description).inner_html)
    self.url = CGI.unescapeHTML((@data/:link).inner_html)
    self.tags = ((@data/'dc:subject').inner_html.empty?) ? CGI.unescapeHTML((@data/'media:category').inner_html) : CGI.unescapeHTML((@data/'dc:subject').inner_html)
    
    published_at = ((@data/'dc:date').inner_html.empty?) ? CGI.unescapeHTML((@data/:pubDate).inner_html) : CGI.unescapeHTML((@data/'dc:date').inner_html)
    self.published_at = Time.parse(published_at.to_s);
  end
  
  def format_lastfm_data
    self.title = CGI.unescapeHTML((@data/:name).inner_html)
    self.description = CGI.unescapeHTML((@data/:artist).inner_html)
    self.url = CGI.unescapeHTML((@data/:url).inner_html)
    self.tags = CGI.unescapeHTML((@data/:album).inner_html)
    self.published_at = Time.parse((@data/:date).inner_html)
    self.published_at += (60 * 60) if Time.now.dst?
    self.image_id = Image.find_or_create_lastfm_image(self) unless cached?
  end
  
  def format_flickr_data
    format_feed_data
    self.image_id = Image.create_flickr_image(self, (@data/'media:content').first[:url]) unless cached?
  end
  
  def format_blogcritical_data
    format_feed_data
    self.url = CGI.unescapeHTML((@data/'feedburner:origLink').inner_html)
    self.description = (@data/'content:encoded').inner_html
  end
  
  def artist_url
    if self.feed.permalink == 'lastfm'
      parts = self.url.split("_")
      parts[0]
    end
  end
  
end