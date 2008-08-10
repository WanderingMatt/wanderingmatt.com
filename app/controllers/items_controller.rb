class ItemsController < ApplicationController
  
  def index
    limit = (params['offset']) ? 10 : 30
    @offset = (params['offset']) ? params['offset'].to_i : 0
    @items = Item.find(:all, :limit => limit, :order => 'published_at DESC', :offset => @offset, :include => [:feed, :image])
  end
  
end