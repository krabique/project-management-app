class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def new
    @project = Project.new if authorized?
  end
  
  def create
    if authorized?
      if @project = Project.create(project_params)
        redirect_to @project, notice: 'Project was successfully created.'
      else
        render :new
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
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
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

end
