require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::FeedsController do
  
  it "should use Admin::FeedsController" do
    controller.should be_an_instance_of(Admin::FeedsController)
  end
  
  it "should fail with no name and password" do
    get :index
    response.should_not be_success
    response.headers["Status"].should =~ /401/
  end
  
  it "should fail with invalid name and password" do
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials("carrie", "bug")
    request.env['HTTP_AUTHORIZATION'] = @credentials
    get :index
    response.should_not be_success
    response.headers["Status"].should =~ /401/
  end
  
  it "should be a success with valid name and password" do
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials("admin", "password")
    request.env['HTTP_AUTHORIZATION'] = @credentials
    get :index
    response.should be_success
  end
  
end

describe Admin::FeedsController, 'GET #index' do
  
  before :each do
    controller.stub!(:authenticate).and_return(true)
    
    @feeds = [mock_model(Feed), mock_model(Feed)]
    Feed.stub!(:find).and_return(@feeds)
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
  
  it 'should find all of the feeds in the database' do
    Feed.should_receive(:find).with(:all).and_return(@feeds)
    do_get
  end

  it 'should assign the feeds for the view' do
    do_get
    assigns[:feeds].should equal(@feeds)
  end

end

describe Admin::FeedsController, 'GET #new' do
  
  before :each do
    controller.stub!(:authenticate).and_return(true)
  end
  
  def do_get
    get :new
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template(:new)
  end
  
end

describe Admin::FeedsController, 'POST #create' do
  
  include FeedSpecHelper
  
  before :each do
    @params = { :feed => valid_feed_params }
    controller.stub!(:authenticate).and_return(true)
    
    @feed = mock_model(Feed)
    @feed.stub!(:new_record?).and_return(true)
    @feed.stub!(:save).and_return(true)
    Feed.stub!(:new).and_return(@feed)
  end
  
  def do_post
    post :create, @params
  end
  
  it 'should create a new feed using the form params' do
    Feed.should_receive(:new).with(@params[:feed]).and_return(@feed)
    do_post
  end
  
  it 'should try to save the new feed' do
    @feed.should_receive(:save)
    do_post
  end
  
  describe 'when the new feed is saved and valid' do
    
    before :each do
      @feed.stub!(:save).and_return(true)
    end
    
    it 'should set a flash notice' do
      do_post
      flash[:notice].should == 'New Feed has been saved.'
    end
  
    it 'should redirect to #index' do
      do_post
      response.should redirect_to(admin_root_path)
    end
    
  end
  
  describe 'when the new feed is not saved becuase it is invalid' do
    
    before :each do
      @feed.stub!(:save).and_return(false)
    end
    
    it 'should render new template' do
      do_post
      response.should render_template(:new)
    end
    
  end
  
end

describe Admin::FeedsController, 'GET #edit' do
  
  include FeedSpecHelper
  
  before :each do
    controller.stub!(:authenticate).and_return(true)
    
    @feed = mock_model(Feed, valid_feed_attributes)
    Feed.stub!(:find).and_return(@feed)
    
  end
  
  def do_get
    get :edit, :id => @feed.id.to_s
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template(:edit)
  end
  
  it 'should find the feed to edit' do
    Feed.should_receive(:find).with(@feed.id.to_s).and_return(@feed)
    do_get
  end
  
  it 'should assign the feed for the view' do
    do_get
    assigns['feed'].should equal(@feed)
  end
  
end

describe Admin::FeedsController, 'PUT #update' do
  
  include FeedSpecHelper
  
  before :each do
    controller.stub!(:authenticate).and_return(true)
    
    @params = { :feed => valid_feed_params }
    
    @feed = mock_model(Feed, valid_feed_attributes)
    @feed.stub!(:update_attributes).and_return(true)
    Feed.stub!(:find).and_return(@feed)
  end
  
  def do_put
    put :update, :id => @feed.id.to_s
  end
  
  it 'should find the feed to update' do
    Feed.should_receive(:find).with(@feed.id.to_s).and_return(@feed)
    do_put
  end
  
  it 'should try to update the feed with the form params' do
    @feed.should_receive(:update_attributes).and_return(true)
    do_put
  end
  
  it 'should set a flash notice' do
    do_put
    flash[:notice].should == 'Feed has been updated.'
  end

  it 'should redirect to #index' do
    do_put
    response.should redirect_to(admin_root_path)
  end
  
  describe 'when the feed is not updated becuase it is invalid' do
    
    before :each do
      @feed.stub!(:update_attributes).and_return(false)
    end
    
    it 'should render edit template' do
      do_put
      response.should render_template(:edit)
    end
    
  end
  
end

describe Admin::FeedsController, 'DELETE #destroy' do
  
  include FeedSpecHelper
  
  before :each do
    controller.stub!(:authenticate).and_return(true)
    @feed = mock_model(Feed, valid_feed_attributes)
    @feed.stub!(:destroy).and_return(true)
    Feed.stub!(:find).and_return(@feed)
  end
  
  def do_delete
    delete :destroy, :id => @feed.id.to_s
  end
  
  it 'should find the feed to destroy' do
    Feed.should_receive(:find).with(@feed.id.to_s).and_return(@feed)
    do_delete
  end
  
  it 'should destroy the feed' do
    @feed.should_receive(:destroy).and_return(true)
    do_delete
  end
  
  it 'should set a flash notice' do
    do_delete
    flash[:notice].should == 'Feed has been deleted.'
  end
  
  it 'should redirect to #index' do
    do_delete
    response.should redirect_to(admin_root_path)
  end
  
end