class CommentsController < ApplicationController
	before_filter :authenticate_admin!, :only => :destroy
	before_filter :get_post_and_associate, :tag_cloud
	layout "sidebar_layout"

  #cache_sweeper :comment_sweeper

	def get_post_and_associate
		@post = Post.find_by_title_for_url(params[:post_id])
		@associate = @post.associate
		@associates = Associate.all
    # logger.debug "Post hash: #{@post.id}"
	end

	def tag_cloud
		@tags = Post.tag_counts_on(:tags)
	end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @post.comments.new(params[:comment])

    respond_to do |format|
      if @comment.save
        session[:comment] = nil
		    CommentMail.new(:body => @comment.body, :name => @comment.name, :email => @comment.email, :associate_email => (@post.associate.name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl"), :post_title => @post.title).deliver
        format.html { redirect_to post_path(@post), notice: 'Uw commentaar is geplaatst.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        session[:comment] = @comment
        format.html { redirect_to post_path(@post), notice: 'Uw commentaar kon niet geplaatst worden.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to associate_post_path(@associate, @post), notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to associate_post_url(@associate, @post) }
      format.json { head :ok }
    end
  end
end
