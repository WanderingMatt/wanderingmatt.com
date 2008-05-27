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
  
  it 'should have many items' do
    Feed.should have_many(:items)
  end
  
end

describe Feed, '#cache_all' do
  
  include FeedSpecHelper
  
  before :each do
    @feed = mock_model(Feed, valid_feed_attributes)
    @item = mock_model(Item)
    @feeds = [@feed]
    @uri = mock(URI)
    @net_http = mock(Net::HTTP)
    @xml = mock(REXML::Document)
    @element = mock('Element')
    @elements = [@element]
    Feed.stub!(:find).and_return(@feeds)
    Feed.stub!(:items).and_return(@item)
    URI.stub!(:parse).and_return(@uri)
    Net::HTTP.stub!(:get).and_return(@net_http)
    REXML::Document.stub!(:new).and_return(@xml)
    @xml.stub!(:elements).and_return(@elements)
    @elements.stub!(:each).and_return(@element)
    Item.stub!(:prepare_and_save).and_return(false)
  end
  
  it 'should find all of the feeds in the database' do
    Feed.should_receive(:find).with(:all).and_return(@feeds)
    Feed.cache_all
  end
  
  describe 'for a single feed' do
  
    it 'should create a new URI object using the Feed url' do
      URI.should_receive(:parse).with(@feed.url).and_return(@uri)
      Feed.cache_all
    end
    
    it 'should get the contents of the feed' do
      Net::HTTP.should_receive(:get).with(@uri).and_return(@net_http)
      Feed.cache_all
    end
    
    it 'should create an xml document' do
      REXML::Document.should_receive(:new).with(@net_http).and_return(@xml)
      Feed.cache_all
    end
    
    it 'should find the feed elements' do
      @xml.should_receive(:elements).and_return(@elements)
      Feed.cache_all
    end
    
    it 'should try to save a new item' do
      Item.should_receive(:prepare_and_save).with(@feed, anything).and_return(false)
      Feed.cache_all
    end
  
  end
  
end