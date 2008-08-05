class Image < ActiveRecord::Base
  
  require 'digest/sha1'
  require 'hpricot'
  require 'open-uri'
  
  def self.find_or_create_lastfm_image(item)
    image = self.find_by_title(item.tags)
    if image
      image.id
    else
      self.create_lastfm_image(item)
    end
  end
  
  def self.create_lastfm_image(item)
    image_id = 0
    
    if !item.description.empty? && !item.tags.empty?
      
      source_url = "http://ws.audioscrobbler.com/1.0/album/#{CGI.escape(item.description)}/#{CGI.escape(item.tags)}/info.xml"
      
      begin
        xml_data = Hpricot.XML(open(source_url))
      rescue
        puts "404 File Not Found!"
      end
      
      if xml_data
        
        images = {
          :large => (xml_data/:coverart/:large).inner_html,
          :medium => (xml_data/:coverart/:medium).inner_html
        }
        
        images.each do |size, img|
          
          saved = false
          path = '/images/lastfm'
          image_name = self.random_file_name+'.jpg'
          #open("#{RAILS_ROOT}/public#{path}/#{image_name}", "wb").write(open(img).read)
          
          img.gsub!("http://", "")
          parts = img.split("/")
          domain = parts[0]
          server_path = img.gsub(domain, "")
          
          Net::HTTP.start(domain) do |http|
            resp = http.get(server_path)
            if resp.code == "200"
              open("#{RAILS_ROOT}/public#{path}/#{image_name}", "wb") do |file|
                file.write(resp.body)
                saved = true
              end
            end
          end
          
          break if saved
        end
      end
    end
    image_id
  end
  
  def self.random_file_name
    chars = ("a".."z").to_a + ("1".."9").to_a 
    string = Array.new(10, '').collect{chars[rand(chars.size)]}.join
    Time.now.strftime("%y%m%d").to_s + '_' + string
  end
  
end