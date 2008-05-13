require File.dirname(__FILE__) + '/../../../spec_helper'

describe '/admin/feeds/index' do
  
  it 'should show the title' do
    render '/admin/feeds/index'
    response.should have_tag('h2', 'Feeds')
  end
  
end