require File.dirname(__FILE__) + '/../spec_helper'

module FeedSpecHelper
  def valid_feed_attributes
    {
      :name => 'Test Feed',
      :url => 'http://www.testing.co.uk/feed.rss'
    }
  end
end

describe Feed do
  
  include FeedSpecHelper
  
  before(:each) do
    @feed = Feed.new
  end
  
  it "should be valid" do
    @feed.attributes = valid_feed_attributes
    @feed.should be_valid
  end
  
  it 'should be invalid without a name' do
    @feed.attributes = valid_feed_attributes.except(:name)
    @feed.should_not be_valid
  end
  
  it 'should be invalid without a url' do
    @feed.attributes = valid_feed_attributes.except(:url)
    @feed.should_not be_valid
  end
  
end