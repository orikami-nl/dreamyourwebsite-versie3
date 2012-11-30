class HomeController < ApplicationController
	# manageable_mercury_content_for :body, :title, :dreamteam, :layout => "home_layout"
	# layout "home_layout"

	def mobile_agent?
		request.user_agent =~ /Mobile|webOS/ and not request.user_agent =~ /iPad/
	end
  
  def parse_boolean(value)    
     [true, 'true', 1, '1', 't'].include?(value.respond_to?(:downcase) ? value.downcase : value)  
  end 

  def mobile?
		false 
		#--- <mobile layout detection turned off> ---   
		#case
    #when !params[:mobile].nil?
    #  parse_boolean(params[:mobile])
    #when !session[:mobile].nil?
    #  session[:mobile]
    #else
    #  mobile_agent?
    #end
		#--- </mobile layout detection turned off> ---
  end

  def index
		@ref = params[:ref]
    if mobile?
      redirect_to mobile_path
    end
    if admin_signed_in?
      @post = Post.first
    else
      @post = Post.where(:draft => false).order("pusblished_at DESC").first
    end
    @project = Project.last
    @partners = Partner.get_random(4)
    @projects = Project.order("created_at DESC").limit(3)
  end

  def full
    session[:mobile] = false
    redirect_to root_path
  end

	#Uitnodiging voor 1-jarig bestaan
	def invitation
		render :layout => false
	end
end
