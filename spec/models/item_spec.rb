require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  
  before(:each) do
    @item = Item.new
  end
  
  it "should be valid" do
    @item.should be_valid
  end
  
end

describe Item, '#prepare_and_save' do
  
  it 'should return false' do
    Item.prepare_and_save.should equal(false)
  end
  
end