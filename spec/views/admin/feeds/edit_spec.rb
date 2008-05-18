require File.dirname(__FILE__) + '/../../../spec_helper'

describe '/admin/feeds/edit' do
  
  include FeedSpecHelper
  
  before :each do
    @feed = mock_model(Feed, valid_feed_attributes)
    assigns['feed'] = @feed
  end
  
  it 'should show the title' do
    render '/admin/feeds/edit'
    response.should have_tag('h2', 'Edit Feed')
  end
  
  it 'should show the edit form' do
    render '/admin/feeds/edit'
    response.should have_tag('form[action=?]', admin_feed_path(@feed))
  end
  
  it 'should show the submit button' do
    render '/admin/feeds/edit'
    response.should have_tag('input[type=submit][value=?]', 'Save Feed')
  end
  
  it 'should show a field to enter name' do
    render '/admin/feeds/edit'
    response.should have_tag('label[for=?]', 'feed_name')
    response.should have_tag('input[type=text][id=?]', 'feed_name')
  end
  
  it 'should show a field to enter url' do
    render '/admin/feeds/edit'
    response.should have_tag('label[for=?]', 'feed_url')
    response.should have_tag('input[type=text][id=?]', 'feed_url')
  end
  
end