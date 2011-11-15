class ServicesController < ApplicationController
	manageable_content_for :title, :body, :webdevelopment, :concept_development, :mobile, :layout => "portfolio_layout"

  def index
  end

	def webdevelopment
	end

	def concept_development
	end

	def mobile
	end
end
