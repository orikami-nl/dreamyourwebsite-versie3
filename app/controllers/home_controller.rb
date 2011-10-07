class HomeController < ApplicationController
	manageable_content_for :body, :title, :layout => "home_layout"
	layout "home_layout"

  def index
		@posts = Post.last(2)
		@project = Project.last
  end

end
