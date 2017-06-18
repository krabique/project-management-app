class DocumentsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :document, :through => :project
  before_action :archived?
  skip_before_action :archived?, only: [:show]
  
  def new
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
      render :edit
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to @project
  end
  
  
  private
  
  def document_params
    params.require(:document).permit(:title, :cloudinary_uri, :creator, 
      :last_editor)
  end
  
  def update_document_transaction
    begin
      Document.transaction do
        @document.update!(document_params)
        @document.update!(last_editor: current_user.id)
        return true
      end
    rescue ActiveRecord::RecordInvalid => e
      return false
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
