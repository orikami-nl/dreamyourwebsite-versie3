class ProjectsController < ApplicationController
	manageable_content_for :webdevelopment, :concept_development, :mobile, :title, :body, :layout => "portfolio_layout"	

	before_filter :authenticate_admin!, :except => [:show, :index, :webdevelopment, :concept_development, :mobile] 
	layout 'application', :except => [:index, :show]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.reverse
		render :layout => 'portfolio_layout'
  end

	def webdevelopment
	end

	def concept_development
	end

	def mobile
	end
  # GET /projects/1
  # GET /projects/1.json
  def show
		@project = Project.find_by_title_for_url(params[:id])
		render :layout => 'sidebar_layout'
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find_by_title_for_url(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find_by_title_for_url(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find_by_title_for_url(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
end
