class PostsController < ApplicationController

	before_filter :authenticate_admin!, :except => [:show, :index, :index_tagged_posts] 
	before_filter :get_associate, :tag_cloud

#  caches_action :index, :show, :unless => :admin?
#  cache_sweeper :post_sweeper

	def get_associate
		@associates = Associate.all
	end

	def tag_cloud
		@tags = Post.tag_counts_on(:tags)
	end

  # GET /posts
  # GET /posts.json
  def index
    @associate = Associate.find_by_name_for_url(params[:associate_id])
    kiss_record "View blog"
    if admin_signed_in?
      @posts = @associate.posts.page(params[:page]).per(5)
    else
      @posts = @associate.posts.where(:draft => false).page(params[:page]).per(5)
    end

  end



  # GET /posts/1
  # GET /posts/1.json
  def show
    kiss_record "View blog post"
    if admin_signed_in?
      @post = Post.find_by_title_for_url(params[:id])
    else
      @post = Post.where(:draft => false).find_by_title_for_url(params[:id])
    end
    if session[:comment].nil?
      @comment = @post.comments.new
    else
      @comment = session[:comment]
    end
		@comments = @post.comments.all.reverse
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @associate = Associate.find_by_name_for_url(params[:associate_id])
    @post = @associate.posts.new

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
    @associate = Associate.find_by_name_for_url(params[:associate_id])
    @post = @associate.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to associate_posts_path(@associate), notice: 'Post was successfully created.' }
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
    @associate = Associate.find_by_name_for_url(params[:associate_id])
    @post = Post.find_by_title_for_url(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to associate_posts_path(@associate), notice: 'Post was successfully updated.' }
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
    @associate = Associate.find_by_name_for_url(params[:associate_id])
    @post = Post.find_by_title_for_url(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to associate_posts_url(@associate) }
      format.json { head :ok }
    end
  end

  def admin?
    admin_signed_in?
  end
end
