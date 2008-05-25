require File.dirname(__FILE__) + '/../spec_helper'

describe FeedsController do
  
  it "should use FeedsController" do
    controller.should be_an_instance_of(FeedsController)
  end
  
end

describe FeedsController, 'GET #index' do
  
  before :each do
    Feed.stub!(:cache_all).and_return(true)
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render index template" do
    do_get
    response.should render_template(:index)
  end
  
  it 'should cache all feeds' do
    Feed.should_receive(:cache_all).once.and_return(true)
    do_get
  end
  
end