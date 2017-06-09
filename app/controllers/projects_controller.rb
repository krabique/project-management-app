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
    @users = User.all
  end
  
  def edit
    unless (can? :manage, Project) || 
      current_user.projects.find_by_id(@project.id)
      redirect_to @project, notice: "You cannot edit this project."
    end
  end
  
  def update
    if params[:image_id].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:image_id])         
      raise "Invalid upload signature" if !preloaded.valid?
      @project.documents.create( { cloudinary_uri: preloaded.identifier, creator: current_user.id } )
    end
    
    params[:project][:user_ids] ||= []
    respond_to do |format|
      update_respond_formatted(format)
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
  
  def update_respond_formatted(format)
    if @project.update(project_params)
      update_respond_formatted_for_successful(@project, format)
    else
      update_respond_formatted_for_unchanged(@project, format)
    end
  end
  
  def update_respond_formatted_for_successful(project, format)
    format.html { redirect_to project, 
      notice: 'Project was successfully updated.' }
    format.json { render :show, status: :ok, location: project }
  end
  
  def update_respond_formatted_for_unchanged(project, format)
    format.html { render :edit }
    format.json { render json: project.errors, 
      status: :unprocessable_entity }
  end
end
