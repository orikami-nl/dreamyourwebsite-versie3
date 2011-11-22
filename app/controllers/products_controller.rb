class ProductsController < ApplicationController

manageable_content_for :title, :body, :sidebar, :webdevelopment, :concept_development, :mobile, :web_excerpt, :concept_excerpt, :mobile_excerpt, :layout => "sidebar_layout"
	layout "sidebar_layout"
	caches_page :index, :webdevelopment, :concept_development, :mobile

	before_filter :parse

	def parse
		# @bla = manageable_layout_content_for :sidebar
	end

	def index
	end

	def webdevelopment
	end

	def concept_development
	end

	def mobile
	end
end
