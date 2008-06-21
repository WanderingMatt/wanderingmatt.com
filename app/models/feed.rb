class Feed < ActiveRecord::Base
  
  require 'rexml/document'
  
  validates_presence_of :name, :url
  
  has_many :items
  
  
  def xml_source
    @xml_source ||= REXML::Document.new Net::HTTP.get(URI.parse(url))
  end
  
  def self.cache_all
    feeds = self.find(:all)
    
    for feed in feeds
      xml = feed.xml_source
      #xml.elements.each '//item' do |item|
      #  Item.prepare_and_save(feed, item)
      #end
      feed.cached_at = Time.zone.now.to_s(:db)
      feed.save!
    end
  end
  
end