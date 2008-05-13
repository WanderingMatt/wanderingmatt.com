class Admin::FeedsController < ApplicationController
  
  before_filter :authenticate
  
  layout 'admin'
  
  def index
  end
  
end