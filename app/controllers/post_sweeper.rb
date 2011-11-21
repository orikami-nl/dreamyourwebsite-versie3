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
    expire_page(:controller => 'home', :action => 'index')
    expire_page '/index.html'

    expire_page(:controller => 'posts', :action => 'index')
    expire_page(:controller => 'posts', :action => 'show')
  end

end
