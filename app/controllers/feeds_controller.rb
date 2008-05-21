class FeedsController < ApplicationController
  
  def index
    Feed.cache
    render :layout => 'admin'
  end
  
end