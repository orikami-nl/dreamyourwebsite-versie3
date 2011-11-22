class Admin::PagesController < Admin::ApplicationController
  before_filter :authenticate_admin!
  cache_sweeper :page_sweeper

  def index
    @pages = pages.order('key ASC, locale ASC')
  end

  def edit
    @page = pages.find(params[:id])
  end

  def update
    @page = pages.find(params[:id])

    if @page.update_attributes(params[:manageable_content_page])
      redirect_to admin_pages_path
    else
      render :edit
    end
  end

  def clear
    Rails.cache.clear
    redirect_to admin_pages_path
  end

  protected

  def pages
    ManageableContent::Manager.pages
  end

end
