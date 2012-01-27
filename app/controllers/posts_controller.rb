class PostsController < ApplicationController
	manageable_content_for :body, :title, :layout => "sidebar_layout"

	before_filter :authenticate_admin!, :except => [:show, :index, :index_tagged_posts] 
	before_filter :get_partner, :tag_cloud
	layout "sidebar_layout"

#  caches_action :index, :show, :unless => :admin?
#  cache_sweeper :post_sweeper

	def get_partner
		@partners = Partner.all
		@partner = Partner.find_by_name_for_url(params[:partner_id])
	end

	def tag_cloud
		@tags = Post.tag_counts_on(:tags)
	end

  # GET /posts
  # GET /posts.json
  def index
    if admin_signed_in?
      @posts = @partner.posts.page(params[:page]).per(5)
    else
      @posts = @partner.posts.where(:draft => false).page(params[:page]).per(5)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if admin_signed_in?
      @post = Post.find_by_title_for_url(params[:id])
    else
      @post = Post.where(:draft => false).find_by_title_for_url(params[:id])
    end
    @comment = @post.comments.new
		@comments = @post.comments.all.reverse
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = @partner.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by_title_for_url(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @partner.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to partner_posts_path(@partner), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find_by_title_for_url(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to partner_posts_path(@partner), notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find_by_title_for_url(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to partner_posts_url(@partner) }
      format.json { head :ok }
    end
  end

  def admin?
    admin_signed_in?
  end
end
