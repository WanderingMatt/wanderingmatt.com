require File.dirname(__FILE__) + '/../spec_helper'

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

describe Feed, '#cache_all' do
  
  it 'should return true'
  it 'should find all of the feeds in the database'
  
  describe 'for a single feed' do
  
    it 'should create a new URI object using the Feed url'
    it 'should get the contents of the feed'
    it 'should try to save a new item'
  
  end
  
end

#describe Feed, 'find and cache' do
#  
#  it 'should return true' do
#    Feed.find_and_cache.should equal(true)
#  end
#  
#  it 'should find all of the feeds' do
#    Feed.should_receive(:find).with(:all).and_return(nil)
#  end
#  
#end