class Admin::FeedsController < ApplicationController
  
  before_filter :authenticate
  
  layout 'admin'
  
  def index
    @feeds = Feed.find(:all)
  end
  
  def new
  end
  
  def create
    @feed = Feed.new(params[:feed])
    @feed.save
    flash[:notice] = 'New Feed has been saved.'
    redirect_to admin_root_path
  end
  
end