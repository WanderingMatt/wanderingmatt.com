class Feed < ActiveRecord::Base
  
  require 'rexml/document'
  
  validates_presence_of :name, :url
  
  def self.find_and_cache

    feeds = self.find(:all)

    for feed in feeds
      
      logger.info "Opening #{feed.name} Feed..."
      logger.info "Feed address is: #{feed.url}"
      
      xml = REXML::Document.new Net::HTTP.get(URI.parse(feed.url))
      
      xml.elements.each '//item' do |item|
        
        new_item = {} and item.elements.each do |e|
          new_item[e.name.gsub(/^dc:(\\w)/,"\\1").to_s] = e.text
        end

      end
      
    end
    
  end
  
end