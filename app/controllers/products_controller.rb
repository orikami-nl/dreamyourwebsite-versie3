class ProductsController < ApplicationController

manageable_content_for :title, :body, :sidebar, :web_development, :web_consultancy, :optimization, :layout => "sidebar_layout"
	layout "sidebar_layout"
	caches_action :index, :web_development, :web_consultancy, :optimization

	def index
		finished("landing_page")
	end

	def web_development
	end

	def web_consultancy
	end

	def optimization
	end
end
