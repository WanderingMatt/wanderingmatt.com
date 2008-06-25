class Feed < ActiveRecord::Base
  
  require 'rexml/document'
  
  validates_presence_of :name, :url
  
  has_many :items
  named_scope :active, :conditions => { :active => true }
  
  def xml_source
    @xml_source ||= REXML::Document.new Net::HTTP.get(URI.parse(url))
  end
  
  def self.cache_all
    feeds = self.active
    items = []
    
    for feed in feeds
      xml = feed.xml_source
      xml.elements.each '//item' do |xml_data|
        item = Item.new
        new_item = item.prepare_and_save(feed, xml_data)
        if new_item
          items << new_item
        end
      end
      feed.cached_at = Time.zone.now
      feed.save!
    end
    
    items
  end
  
end