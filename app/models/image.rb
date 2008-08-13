class Image < ActiveRecord::Base
  
  require 'RMagick'
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
    
    image = Image.new
    
    if !item.description.empty? && !item.tags.empty?
      
      image.title = item.tags
      image.source_url = "http://ws.audioscrobbler.com/1.0/album/#{CGI.escape(item.description)}/#{CGI.escape(item.tags)}/info.xml"
      
      if image.xml_source
        if image.download_image('lastfm', (image.xml_source/:coverart/:large).inner_html)
          image.save!
          image.generate_thumbnail
        end
      end
    end
    
    image.id || 0
  end
  
  def self.create_flickr_image(item, url)
    image = Image.new
    image.title = item.tags
    image.source_url = item.url
    image.source_image_url = url
    
    if image.download_image('flickr', url, 'png')
      image.flickr_resize
      image.save!
    end
    
    image.id || 0
  end
  
  def random_file_name
    chars = ("a".."z").to_a + ("1".."9").to_a 
    string = Array.new(10, '').collect { chars[rand(chars.size)] }.join
    Time.now.strftime("%y%m%d").to_s + '_' + string
  end
  
  def xml_source
    begin
      @xml_source ||= Hpricot.XML(open(source_url))
    rescue
      puts "404 File Not Found!"
      false
    end
  end
  
  def download_image(target_folder, location, ext = 'jpg')
    path = "/images/items/#{target_folder}"
    name = random_file_name+'.'+ext
    
    self.source_image_url = location
    location = split_domain_and_path(location)
    
    Net::HTTP.start(location[:domain]) do |http|
      resp = http.get(location[:path])
      if resp.code == "200"
        open("#{RAILS_ROOT}/public#{path}/#{name}", "wb") do |file|
          file.write(resp.body)
          self.path = path
          self.name = name
          true
        end
      end
    end
  end
  
  def generate_thumbnail()
    img = Magick::Image.read("#{RAILS_ROOT}/public#{self.path}/#{self.name}").first
    thumb = img.scale(46, 46)
    thumb.write "#{RAILS_ROOT}/public#{self.path}/#{self.thumb}"
  end
  
  def flickr_resize()
    original_image_path = "#{RAILS_ROOT}/public#{self.path}/#{self.name}"
    original_image = Magick::Image.read(original_image_path).first
    original_image.change_geometry!('408') do |cols, rows, img|
      img.resize!(cols, rows)
    end
    new_file_name = random_file_name+'.jpg'
    original_image.write "#{RAILS_ROOT}/public#{self.path}/#{new_file_name}"
    self.name = new_file_name
    File.delete(original_image_path)
  end
  
  def split_domain_and_path(location)
    location = location.gsub("http://", "")
    parts = location.split("/")
    r = { :domain => parts[0] }
    r[:path] = location.gsub(r[:domain], "")
    r
  end
  
  def thumb
    @thumb ||= self.name.gsub(".jpg", "_thumb.jpg")
  end
  
  def full_path
    @full_path ||= self.path + '/' + self.name
  end
  
  def thumb_path
    @thumb_path ||= self.path + '/' + self.thumb
  end
  
end