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
    begin
      expire_action(:controller => "/" + page.key, :action => "index")
      expire_action(:controller => "/" + page.key, :action => "show")
      expire_action(:controller => "/" + page.key, :action => "webdevelopment")
      expire_action(:controller => "/" + page.key, :action => "concept_development")
    rescue
    end
    Rails.logger.info "PAGEPAGEPAGE: " + page.inspect
    Rails.logger.info "PAGEPAGEPAGE: "+page.key

    # expire_page(:controller => 'projects', :action => 'show',:id => project)
  end

  def page
    ManageableContent::Page
  end

end
