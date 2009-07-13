class ColourSchemesController < ApplicationController
  
  def index
    @colour_schemes = ColourScheme.all
    respond_to { |format| format.css }
  end
  
end