class FeedsController < ApplicationController
  
  def index
    @items = Feed.cache_all
    render :layout => 'admin'
  end
  
end