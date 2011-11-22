class TermsAndConditionsController < ApplicationController
	manageable_content_for :body, :title
	caches_action :index
  def index
  end

end
