class ProductsController < ApplicationController

	def index
		finished("landing_page")
	end

	def flow
		render :layout => "application"
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
