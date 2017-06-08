class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update]
  before_action :set_project, only: [:show, :edit, :update]
  
  def show
  end
  
  def edit
    unless (can? :manage, Project) || 
      current_user.projects.find_by_id(@project.id)
      redirect_to @project, notice: "You cannot edit this project."
    end
  end
  
  def update
    #if params[:image_id].present?
    #  preloaded = Cloudinary::PreloadedFile.new(params[:image_id])         
    #  raise "Invalid upload signature" if !preloaded.valid?
    #  @project.documents.create( { cloudinary_uri: preloaded.identifier } )
    #end
    
    #params[:project][:user_ids] ||= []
    respond_to do |format|
      update_respond_formatted(format)
    end
  end
  
  private
  
  def set_project
    @project = @document.project
  end
  
  def set_document
    @document = Document.find_by(id: params[:id])
  end
  
  def project_params
    params.require(:project).permit(:title, :cloudinary_uri)
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
