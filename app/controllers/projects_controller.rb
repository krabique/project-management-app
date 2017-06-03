class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  
  def index
    if params[:tag]
      @projects = Project.tagged_with(params[:tag])
    else
      @projects = Project.all
    end
  end
  
  def show
  end
  
  def edit
    unless (can? :manage, Project) || current_user.projects.find_by_id(@project.id)
      redirect_to @project, notice: "You cannot edit this project."
    end
  end
  
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def set_project
    @project = Project.find(params[:id])
  end
  
  def project_params
    params.require(:project).permit(:title, :description, :tag_list)
  end
end
