# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  require 'hpricot'
  
  def show_flash(key = :notice)
    if flash[key]
      '<p class="flash '+key.to_s+'">' + flash[key] + '</p>'
    else
      ''
    end
  end
  
  def current_colour_scheme
    unless @current_colour_scheme
      colour_schemes.each do |colour|
        if params['colour_scheme'] == colour.downcase
          @current_colour_scheme = colour + ' fixed'
        end
      end
    end
    @current_colour_scheme ||= colour_schemes[rand(colour_schemes.length)]
  end
  
  def colour_schemes
    @colour_schemes ||= ColourScheme.list
  end
  
  def current_age
    now = Time.now
    dob = Time.local(1987, "Aug", 18)
    age = now.year - dob.year - (dob.to_time.change(:year => now.year) > now ? 1 : 0)
  end
  
  def find_image_path(image)
    path = ''
		if File.exists?("#{RAILS_ROOT}/public#{image.thumb_path}")
		  path = image.thumb_path
		elsif File.exists?("#{RAILS_ROOT}/public#{image.full_path}")
		  path = image.full_path
		end
		path
  end
  
  def lastfm_album_url(item)
    "http://www.last.fm/music/#{CGI.escape(item.description)}/#{CGI.escape(item.tags)}/"
  end
  
  def tweet(text)
    text.gsub!("andypearson:", 'Andy Pearson')
    text = auto_link(text)
    text.gsub!(/@(\w+)/) do |s|
      '@<a href="http://twitter.com/' + $1 + '">' + $1 + '</a>'
    end
    widont(text)
  end
  
  def github(text)
    text.gsub!("andypearson ", '')
    text = text.capitalize
    widont(text)
  end
  
  def link_to_tags(tags, base_url)
    r = ''
    tags = tags.split(' ')
    tags.each do |tag|
      r += '<a href="'+base_url+tag+'">'+tag+'</a>'
      r += (tag == tags[(tags.size)-2]) ? '&nbsp;and&nbsp;' : ', ' if (tag != tags[(tags.size)-1])
    end
    r
  end
  
  def blog(content)
    content.gsub!("<![CDATA[", "")
    content.gsub!("]]>", "")
    post = Hpricot(content);
    (post/"div.feedflare").remove
    (post/"img").remove
    (post/"p:last-child").remove if (content.include? 'more-link')
    post
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def embed_youtube_video(raw_url)
    video_id = raw_url.split('=')[1]
    url = "http://www.youtube.com/v/#{video_id}&amp;hl=en&amp;fs=1&amp;showinfo=0&amp;rel=0"
    <<-html
      <object type="application/x-shockwave-flash" data="#{url}" width="408" height="245">
      	<param name="movie" value="#{url}" /><param name="FlashVars" value="playerMode=embedded" />
      	<param name="wmode" value="transparent" />
      </object>
    html
  end
  
end