class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    expire_cache_for(post)
  end

  def after_update(post)
    expire_cache_for(post)
  end

  def after_destroy(post)
    expire_cache_for(post)
  end

  private
  def expire_cache_for(post)
    expire_action(:controller => 'home', :action => 'index')
    expire_action(:controller => 'blog', :action => 'index')
    expire_action(:controller => 'blog', :action => 'tag_cloud')
    # expire_action '/index.html'


    expire_action(:controller => 'posts', :action => 'index')
    expire_action(:controller => 'posts', :action => 'show',:id => post)
  end

end
