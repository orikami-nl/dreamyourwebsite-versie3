class PageSweeper <  ActionController::Caching::Sweeper
  observe ManageableContent::Page

  def after_create(page)
    expire_cache_for(page)
  end

  def after_update(page)
    expire_cache_for(page)
  end

  def after_destroy(page)
    expire_cache_for(page)
  end

  private
  def expire_cache_for(page)
    ApplicationController::expire_page "/" + page.key
    ApplicationController::expire_page "/" + page.key + "/show"
    ApplicationController::expire_page "/" + page.key + "/webdevelopment"
    ApplicationController::expire_page "/" + page.key + "/concept_development"
    Rails.logger.info "PAGEPAGEPAGE: " + page.inspect
    Rails.logger.info "PAGEPAGEPAGE: "+page.key

    # expire_page(:controller => 'projects', :action => 'show',:id => project)
  end

  def page
    ManageableContent::Page
  end

end
