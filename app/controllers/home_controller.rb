class HomeController < ApplicationController
	manageable_content_for :body, :title, :dreamteam, :web_slide, :concept_slide, :mobile_slide, :layout => "home_layout"
	layout "home_layout"

  def mobile_agent?
    request.user_agent =~ /Mobile|webOS/
    #false
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
    @posts = Post.last(2)
    @project = Project.last
		begin
	    @lasttweet = Twitter.user_timeline("dreamyourweb").first.text  
	    @lasttweet = @lasttweet.strip.gsub(/(http:\/\/\S+)/) {|s| '<a href=' + s + '>' + s + '</a>'}
	    @lasttweet = @lasttweet.strip.gsub(/(#\w+)/) {|s| '<a href=http://twitter.com/#!/search?q=%23' + s.gsub(/#/,"") + '>' + s + '</a>'}
	    @lasttweet = @lasttweet.strip.gsub(/(@\w+)/) {|s| '<a href=http://twitter.com/#!/' + s.gsub(/@/,"") + '>' + s + '</a>'}
		rescue OpenURI::HTTPError #twitter limiting
			@lasttweet = nil
		end
    #@lasttweet = @lasttweet.html_safe
    # @lasttweet = Twitter.user_timeline("invite2eat",{:include_entities => 1}).first.hashtags
    
  end

  def full
    session[:mobile] = false
    redirect_to root_path
  end

end
