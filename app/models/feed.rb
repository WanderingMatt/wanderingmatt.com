class Feed < ActiveRecord::Base
  
  require 'hpricot'
  require 'open-uri'
  
  validates_presence_of :name, :url
  
  has_permalink :name, :permalink
  has_many :items, :order => 'published_at DESC'
  named_scope :active, :conditions => { :active => true }
    
  def self.cache_all
    feeds = self.active
    @items = []
    
    for feed in feeds
      
      feed.elements.each do |xml_data|
        item = Item.new
        new_item = item.prepare_and_save(feed, xml_data)
        @items << new_item if new_item
      end
      
      feed.cached_at = Time.zone.now
      feed.save!
    end
    
    @items
  end
  
  def xml_source
    @xml_source ||= Hpricot.XML(open(url))
  end
  
  def format
    @format = 'RSS'
    @format = 'XML' if url.end_with?('.xml')
    @format = 'ATOM' if url.end_with?('.atom') || url.match(/youtube/)
    @format
  end
  
  def elements
    
    if (format == 'XML')
      (xml_source/:track)
    elsif (format == 'ATOM')
      (xml_source/:entry)
    else
      (xml_source/:item)
    end
  end
  
end