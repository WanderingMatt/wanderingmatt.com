class ItemsController < ApplicationController
  
  caches_page :index
  
  def index
    limit = (params['id']) ? 10 : 30
    offset = (params['id']) ? params['id'].to_i : 0
    @items, @total, @offset = Item.lifestream(offset, limit)
  end
  
end