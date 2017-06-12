class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :new, :create]
  
  def new
    if authorized?
      @document = Document.new
    end
  end
  
  def create
    if authorized?
      respond_to do |format|
        create_action_respond_formatted(format)
      end
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
      respond_to do |format|
        update_action_respond_formatted(format)
      end
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    if authorized?
      @document.destroy
      redirect_to @project
    end
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
  
  def update_action_respond_formatted(format)
    if update_document_transaction
      update_action_respond_formatted_for_successful(@document, format)
    else
      update_action_respond_formatted_for_unchanged(@document, format)
    end
  end
  
  def update_action_respond_formatted_for_successful(document, format)
    format.html { redirect_to document.project, 
      notice: 'Document was successfully updated.' }
    format.json { render :show, status: :ok, location: document }
  end
  
  def update_action_respond_formatted_for_unchanged(document, format)
    format.html { render :edit }
    format.json { render json: document.errors, 
      status: :unprocessable_entity }
  end
  
  def update_document_transaction
    Document.transaction do
      @document.update!(document_params)
      @document.update!(last_editor: current_user.id)
      return true
    end
  end
  
  def create_action_respond_formatted(format)
    if preloaded_cloudinary = create_cloudinary_link
      create_and_respond(format, preloaded_cloudinary)
    end
  end
  
  def create_and_respond(format, preloaded_cloudinary)
    if create_document(preloaded_cloudinary)
      create_action_respond_formatted_for_successful(format)
    else
      update_action_respond_formatted_for_unchanged(format)
    end
  end
  
  def create_action_respond_formatted_for_successful(format)
    format.html { redirect_to @project, 
      notice: 'Document was successfully created.' }
    format.json { render :show, status: :created, location: @project }
  end
  
  def update_action_respond_formatted_for_unchanged(format)
    format.html { render :new }
    format.json { render json: @project.errors, status: :unprocessable_entity }
  end
  
  def create_document(preloaded_cloudinary)
    @project.documents.create( { title: params[:document][:title], 
      cloudinary_uri: preloaded_cloudinary.identifier, 
      creator: current_user.id } )
  end
  
end
