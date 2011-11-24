class BlogController < ApplicationController
  manageable_content_for :body, :title, :layout => "sidebar_layout"

  layout "sidebar_layout"
  before_filter :tag_cloud  
  caches_action :index, :unless => :admin?
  cache_sweeper :post_sweeper

  def tag_cloud
  	@tags = Post.tag_counts_on(:tags)
  end

  def index
  	if !params[:tag].nil?
  		@posts = Post.tagged_with(params[:tag]).page(params[:page]).per(5)
  	else
  		@posts = Post.page(params[:page]).per(5)
  	end
  	@partners = Partner.all
  end

  private

  def admin?
  	admin_signed_in?
  end
end
