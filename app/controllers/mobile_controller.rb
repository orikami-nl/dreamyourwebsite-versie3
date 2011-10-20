class MobileController < ApplicationController
  layout "mobile"

  def index
    session[:mobile] = true    
  end


end
