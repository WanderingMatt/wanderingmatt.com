# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def show_flash(key = :notice)
    if flash[key]
      '<p class="flash '+key.to_s+'">' + flash[key] + '</p>'
    else
      ''
    end
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
end