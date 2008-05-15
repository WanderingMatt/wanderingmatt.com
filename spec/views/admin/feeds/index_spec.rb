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
  
  it 'should not show a flash by default' do
    render '/admin/feeds/index'
    response.should_not have_tag('p', 'This is a testing flash notice!')
  end
  
  it 'should show a flash if it exists' do
    flash[:notice] = 'This is a testing flash notice!'
    render '/admin/feeds/index'
    response.should have_tag('p', 'This is a testing flash notice!')
  end
  
  describe 'with no feeds' do
  
    it 'should not show the table of feeds' do
      render '/admin/feeds/index'
      response.should_not have_tag('table')
    end
    
  end
  
  describe 'with some feeds' do
    
    before :each do
      assigns[:feeds] = [mock_model(Feed), mock_model(Feed)]
    end
    
    it 'should show the feeds table' do
      render '/admin/feeds/index'
      response.should have_tag('table')
    end
    
    it 'should show a row for each feed' do
      render '/admin/feeds/index'
      response.should have_tag('tbody') do
        with_tag('tr')
        with_tag('tr')
      end
    end
    
  end
  
end