# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def show_flash(key = :notice)
    if flash[key]
      '<p class="flash '+key.to_s+'">' + flash[key] + '</p>'
    else
      ''
    end
  end
  
end
