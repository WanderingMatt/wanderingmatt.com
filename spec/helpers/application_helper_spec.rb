require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper, 'flashes method' do
  
  include ApplicationHelper

  it 'should return an empty string by default' do
    show_flash.should == ''
  end
  
  it 'should return a paragraph containing the flash message' do
    flash[:notice] = 'This is a test!'
    show_flash.should == '<p class="flash notice">This is a test!</p>'
  end
  
  it 'should return a paragraph for a different key' do
    flash[:warning] = 'This is a warning test!'
    show_flash(:warning).should == '<p class="flash warning">This is a warning test!</p>'
  end
  
end