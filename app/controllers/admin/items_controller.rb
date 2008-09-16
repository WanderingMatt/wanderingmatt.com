class Admin::ItemsController < ApplicationController
  
  cache_sweeper :site_sweeper, :only => [:destroy]
  before_filter :authenticate
  layout 'admin'
  
  def index
    @feed = Feed.find(params[:feed_id], :include => [:items])
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = 'Item has been deleted.'
    redirect_to admin_feed_items_path(@item.feed_id)
  end
  
end