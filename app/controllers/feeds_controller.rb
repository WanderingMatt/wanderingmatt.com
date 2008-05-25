class FeedsController < ApplicationController
  
  def index
    Feed.cache_all
    render :layout => 'admin'
  end
  
end