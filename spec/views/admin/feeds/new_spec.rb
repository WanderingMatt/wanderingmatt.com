require File.dirname(__FILE__) + '/../../../spec_helper'

describe '/admin/feeds/new' do
  
  it 'should show the title' do
    render '/admin/feeds/new'
    response.should have_tag('h2', 'Add a New Feed')
  end
  
end