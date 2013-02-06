class SitemapController < ApplicationController
  def index
     @not_so_static_pages = [blog_url, projects_url]
     @static_pages = [root_url, about_url, contact_url, products_url, flow_url]
     @really_static_pages = [terms_and_conditions_url, disclaimer_url]
     @posts = Post.all
     @projects = Project.all
     @associates = Associate.all

     respond_to do |format|
       format.xml
     end
   end
end
