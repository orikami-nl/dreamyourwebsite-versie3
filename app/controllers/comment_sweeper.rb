class CommentSweeper < ActionController::Caching::Sweeper
  observe Comment

  def after_create(comment)
    expire_cache_for(comment)
  end

  def after_update(comment)
    expire_cache_for(comment)
  end

  def after_destroy(comment)
    expire_cache_for(comment)
  end

  private
  def expire_cache_for(comment)
    @post = Post.find_by_title_for_url(params[:post_id])
    expire_page(:controller => 'posts', :action => 'show',:id => params[:post_id])
    logger.debug "Post hash: #{@post.id}"
  end

end
