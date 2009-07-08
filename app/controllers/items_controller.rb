class ItemsController < ApplicationController
  
  caches_page :index
  
  def index
    limit = (params['id']) ? 10 : 30
    @offset = (params['id']) ? params['id'].to_i : 0
    @items = Item.find_lifestream(@offset, limit)
    @total = Item.count_lifestream(@offset)
  end
  
end