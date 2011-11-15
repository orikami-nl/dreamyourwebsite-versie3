class ProductsController < ApplicationController
	manageable_content_for :title, :body, :sidebar, :webdevelopment, :concept_development, :mobile, :layout => "sidebar_layout"
	layout "sidebar_layout"

  def index
  end

	def webdevelopment
	end

	def concept_development
	end

	def mobile
	end
end
