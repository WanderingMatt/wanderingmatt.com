class ItemsController < ApplicationController
  caches_page :index
  
  def index
    limit = (params['id']) ? 10 : 30
    @offset = (params['id']) ? params['id'].to_i : 0
    @items = Item.find(:all, :limit => limit, :order => 'published_at DESC', :offset => @offset, :include => [:feed, :image])
    @total = Item.count - @offset
  end
  
end