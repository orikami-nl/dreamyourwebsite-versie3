class ProjectSweeper < ActionController::Caching::Sweeper
  observe Project

  def after_create(project)
    expire_cache_for(project)
  end

  def after_update(project)
    expire_cache_for(project)
  end

  def after_destroy(project)
    expire_cache_for(project)
  end

  private
  def expire_cache_for(project)
    expire_page(:controller => 'projects', :action => 'index')
    expire_page(:controller => 'projects', :action => 'show',:id => project)
  end

end
