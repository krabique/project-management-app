class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  load_and_authorize_resource
  before_action(only: [:update]) { archived? project_params[:archived] }

  def new
  end
  
  def create
    if @project = Project.create(project_params)
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end
  
  def index
    if params[:tag]
      @projects = Project.tagged_with(params[:tag])
    elsif params[:search]
      @projects = Project.search params[:search]
    else
      @projects = Project.all
    end
  end
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    params[:project][:user_ids] ||= []
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end
  
  
  private
  
  def set_project
    @project = Project.find(params[:id])
  end
  
  def project_params
    if current_user.manager_role?
      params.require(:project).permit(:title, :description, :tag_list, :search, :archived,
        { :user_ids => [] } 
      )
    else
      params.require(:project).permit(:title, :description, :tag_list, :search)
    end
  end

end
