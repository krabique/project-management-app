class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :new, :create]
  load_and_authorize_resource
  before_action :archived?, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @document = Document.new
  end
  
  def create
    if preloaded_cloudinary = create_cloudinary_link
      create_document(preloaded_cloudinary)
      redirect_to @project, notice: 'Document was successfully created.'
    else
      redirect_to new_project_document_path(@project), 
        alert: 'There was an error trying to create a documment.'
    end
  end
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    if update_document_transaction
      redirect_to @document.project, 
        notice: 'Document was successfully updated.'
    else
      redirect_to edit_project_document(@project, @document), 
        alert: 'There was an error updating the document.'
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to @project
  end
  
  
  private
  
  def set_project
    unless @project = @document.project
      @project = Project.find_by(id: params[:project_id])
    end
  end
  
  def set_document
    unless @document = Document.find_by(id: params[:id])
      @document = Document.new
    end
  end
  
  def document_params
    params.require(:document).permit(:title, :cloudinary_uri, :creator, 
      :last_editor)
  end
  
  def update_document_transaction
    Document.transaction do
      @document.update!(document_params)
      @document.update!(last_editor: current_user.id)
      return true
    end
  end
  
  def create_document(preloaded_cloudinary)
    @project.documents.create( { 
      title:            params[:document][:title], 
      cloudinary_uri:   preloaded_cloudinary.identifier, 
      creator:          current_user.id 
    } )
  end
  
end
