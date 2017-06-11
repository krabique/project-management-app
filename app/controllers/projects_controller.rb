class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def new
    @project = Project.new if authorized?
  end
  
  def create
    if authorized?
      respond_to do |format|
        create_action_respond_formatted(format)
      end
    end
  end
  
  def index
    if params[:tag]
      @projects = Project.tagged_with(params[:tag])
    else
      @projects = Project.all
    end
  end
  
  def show
    @users = User.all
  end
  
  def edit
    authorized?
  end
  
  def update
    if authorized?
      params[:project][:user_ids] ||= []
      respond_to do |format|
        update_action_respond_formatted(format)
      end
    end
  end
  
  
  private
  
  def set_project
    @project = Project.find(params[:id])
  end
  
  def project_params
    if can? :manage, Project
      params.require(:project).permit(:title, :description, :tag_list, 
        { :user_ids => [] } 
      )
    else
      params.require(:project).permit(:title, :description, :tag_list)
    end
  end
  
  def update_action_respond_formatted(format)
    if @project.update(project_params)
      update_action_respond_formatted_for_successful(@project, format)
    else
      update_action_respond_formatted_for_unchanged(@project, format)
    end
  end
  
  def update_action_respond_formatted_for_successful(project, format)
    format.html { redirect_to project, 
      notice: 'Project was successfully updated.' }
    format.json { render :show, status: :ok, location: project }
  end
  
  def update_action_respond_formatted_for_unchanged(project, format)
    format.html { render :edit }
    format.json { render json: project.errors, 
      status: :unprocessable_entity }
  end
  
  def create_action_respond_formatted(format)
    if @project = Project.create(project_params)
      create_action_respond_formatted_for_successful(format)
    else
      create_action_respond_formatted_for_unchanged(format)
    end
  end
  
  def create_action_respond_formatted_for_successful(format)
    format.html { redirect_to @project, 
      notice: 'Project was successfully created.' }
    format.json { render :show, status: :created, location: @project }
  end
  
  def create_action_respond_formatted_for_unchanged(format)
    format.html { render :new }
    format.json { render json: @project.errors, status: :unprocessable_entity }
  end  
end
