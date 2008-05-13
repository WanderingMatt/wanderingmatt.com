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
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
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
  
end