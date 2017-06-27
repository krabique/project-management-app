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
    if safe_destroy_document
      redirect_to @project, notice: "Document was successfully deleted."
    else
      redirect_to @project, alert: "There was an error deleting the document."
    end
  end
  
  
  private
  
  def document_params
    params.require(:document).permit(:title, :cloudinary_uri, :creator, 
      :last_editor)
  end
  
  def update_document_transaction
    begin
      @document.update!( document_params.merge(last_editor: 
        current_user.id) )
      return true
    rescue ActiveRecord::RecordInvalid
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
  
  def safe_destroy_document
    begin
      destroy_document_action
    rescue Exception
      return false
    end
  end
  
  def destroy_document_action
    cl_document_name = File.basename(@document.cloudinary_uri, ".*")
    cl_delete_hash = Cloudinary::Api.delete_resources(cl_document_name)
    @document.destroy! if 
      cl_delete_hash['deleted'][cl_document_name] == "deleted"
  end
end
