class CommentsController < ApplicationController
	before_filter :authenticate_admin!, :only => :destroy
	before_filter :get_post_and_partner, :tag_cloud
	before_filter :check_honeypots, :only => [:create]
	layout "sidebar_layout"
	manageable_content_for :body, :title, :layout => "sidebar_layout"

  cache_sweeper :comment_sweeper

  def check_honeypots
    return true if honeypot_untouched?
    flash[:notice] = 'U bent een spambot, of gebruikt een vreemd script. (Zo niet, dan heb ik overdreven gereageerd. Probeer het alstublieft nog eens.)'
    redirect_to :back
    return false
  end

  def honeypot_untouched?
    submitted = params['its_so_sweet']
    return false if submitted.blank?
    submitted['email'] == 'john@doe.com' && submitted['name'] == '' && submitted['agree'].blank?
	end

	def get_post_and_partner
		@post = Post.find_by_title_for_url(params[:post_id])
		@partner = Partner.find_by_name_for_url(params[:partner_id])
		@partners = Partner.all
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
		    CommentMail.new(:body => @comment.body, :name => @comment.name, :email => @comment.email, :partner_email => (@post.partner.name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl"), :post_title => @post.title).deliver
        format.html { redirect_to partner_post_path(@partner, @post), notice: 'Uw commentaar is geplaatst.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to partner_post_path(@partner, @post), notice: 'Uw commentaar kon niet geplaatst worden.' }
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
        format.html { redirect_to partner_post_path(@partner, @post), notice: 'Comment was successfully updated.' }
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
      format.html { redirect_to partner_post_url(@partner, @post) }
      format.json { head :ok }
    end
  end
end
