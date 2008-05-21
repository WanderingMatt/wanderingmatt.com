require File.dirname(__FILE__) + '/../../spec_helper'

describe '/feeds/index' do
  
  it 'should show the title' do
    render '/feeds/index'
    response.should have_tag('h2', 'Cache Feeds')
  end
  
end