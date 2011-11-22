class TermsAndConditionsController < ApplicationController
	manageable_content_for :body, :title
	caches_page :index
  def index
  end

end
