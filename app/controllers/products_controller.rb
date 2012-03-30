class ProductsController < ApplicationController

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

	def tech
		render :layout => "application"
	end

end
