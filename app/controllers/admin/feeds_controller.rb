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
    
    if @feed.save
      flash[:notice] = 'New Feed has been saved.'
      redirect_to admin_root_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @feed = Feed.find(params[:id])
  end
  
  def update
    @feed = Feed.find(params[:id])
    
    if @feed.update_attributes(params[:feed])
      flash[:notice] = 'Feed has been updated.'
      redirect_to admin_root_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = 'Feed has been deleted.'
    redirect_to admin_root_path
  end
  
end