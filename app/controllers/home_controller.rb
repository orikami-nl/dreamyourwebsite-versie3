class HomeController < ApplicationController
	# manageable_content_for :body, :title, :dreamteam, :layout => "home_layout"
	layout "home_layout"

  caches_action :index

	def mobile_agent?
	  request.user_agent =~ /Mobile|webOS/ and not request.user_agent =~ /iPad/
	end
  
  def parse_boolean(value)    
     [true, 'true', 1, '1', 't'].include?(value.respond_to?(:downcase) ? value.downcase : value)  
  end 

  def mobile?
    case
    when !params[:mobile].nil?
      parse_boolean(params[:mobile])
    when !session[:mobile].nil?
      session[:mobile]
    else
      mobile_agent?
    end 
  end

  def index
		@ref = params[:ref]
    if mobile?
      redirect_to mobile_path
    end
    @post = Post.first
    @project = Project.last
  end

  def full
    session[:mobile] = false
    redirect_to root_path
  end

end
