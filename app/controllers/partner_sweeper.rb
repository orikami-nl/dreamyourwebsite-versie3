class PartnerSweeper < ActionController::Caching::Sweeper
  observe Partner

  def after_create(partner)
    expire_cache_for(partner)
  end

  def after_update(partner)
    expire_cache_for(partner)
  end

  def after_destroy(partner)
    expire_cache_for(partner)
  end

  private
  def expire_cache_for(partner)
    expire_page(:controller => 'partners', :action => 'index')
    expire_page(:controller => 'partners', :action => 'show',:id => partner)
  end

end
