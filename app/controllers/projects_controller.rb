class ProjectsController < ApplicationController
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
      @projects = Project.tagged_with(params[:tag]).page(params[:page]).per(5)
    elsif params[:search]
      @projects = Kaminari.paginate_array(
        Project.search(params[:search]) ).page(params[:page]).per(5)
    else
      @projects = Project.all.page(params[:page]).per(5)
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
    params.require(:project)
      .permit(:title, :description, :tag_list, :search, :archived,
      { :user_ids => [] } 
    )
  end

end
