require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::FeedsController do
  
  it "should use Admin::FeedsController" do
    controller.should be_an_instance_of(Admin::FeedsController)
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