require File.dirname(__FILE__) + '/../../../spec_helper'

describe '/admin/feeds/index' do
  
  it 'should show the title' do
    render '/admin/feeds/index'
    response.should have_tag('h2', 'Feeds')
  end
  
  it 'should show an "Add a New Feed" link' do
    render '/admin/feeds/index'
    response.should have_tag('a[href=?]', new_admin_feed_path, 'Add a New Feed')
  end
  
end