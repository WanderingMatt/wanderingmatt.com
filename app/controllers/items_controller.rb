class ItemsController < ApplicationController
  
  def index
    @items = Item.find(:all, :limit => 20, :order => 'published_at DESC')
  end
  
end