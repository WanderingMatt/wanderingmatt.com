class Admin::PreviewController < ApplicationController

  def index
    
    @items = []
    feeds = Feed.find(:all, :conditions => { :visible => true }, :order => 'cached_at DESC')
    feeds.each do |feed|
      @items << Item.find(:first,
        :conditions => { :feed_id => feed.id },
        :order => 'published_at DESC',
        :include => [:feed, :image]
      )
    end
    
    @total = @items.size
    @offset = 0
    @preview = true
    render :template => 'items/index'
    
  end

end