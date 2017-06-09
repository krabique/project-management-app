class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  
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
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to @project
  end
  
  private
  
  def set_project
    @project = @document.project
  end
  
  def set_document
    @document = Document.find_by(id: params[:id])
  end
  
  def document_params
    params.require(:document).permit(:title, :cloudinary_uri, :creator, 
      :last_editor)
  end
  
  def update_respond_formatted(format)
    if @document.update(document_params)
      update_respond_formatted_for_successful(@document, format)
    else
      update_respond_formatted_for_unchanged(@document, format)
    end
  end
  
  def update_respond_formatted_for_successful(document, format)
    format.html { redirect_to document, 
      notice: 'Document was successfully updated.' }
    format.json { render :show, status: :ok, location: document }
  end
  
  def update_respond_formatted_for_unchanged(document, format)
    format.html { render :edit }
    format.json { render json: document.errors, 
      status: :unprocessable_entity }
  end
end
