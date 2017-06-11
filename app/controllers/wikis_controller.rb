class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def new
    @project = Project.find_by(id: params[:id])
    if authorized?
      @wiki = Wiki.new
    end
  end
  
  def create
    @project = Project.find_by_id(params[:id])
    if authorized?
      respond_to do |format|
        create_action_respond_formatted(format)
      end
    end
  end
  
  def index
    @wikis = Wiki.all
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
    @wiki = Wiki.find(params[:id])
    if authorized?
      @wiki.destroy
      redirect_to @project
    end
  end
  
  
  private
  
  def set_project
    @project = @wiki.project
  end
  
  def set_wiki
    @wiki = Wiki.find_by(id: params[:id])
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
  
  def update_action_respond_formatted(format)
    if update_wiki_transaction
      update_action_respond_formatted_for_successful(@wiki, format)
    else
      update_action_respond_formatted_for_unchanged(@wiki, format)
    end
  end
  
  def update_action_respond_formatted_for_successful(wiki, format)
    format.html { redirect_to wiki.project, 
      notice: 'Wiki was successfully updated.' }
    format.json { render :show, status: :ok, location: wiki }
  end
  
  def update_action_respond_formatted_for_unchanged(wiki, format)
    format.html { render :edit }
    format.json { render json: wiki.errors, 
      status: :unprocessable_entity }
  end
  
  def update_wiki_transaction
    Document.transaction do
      @wiki.update!(wiki_params)
      @wiki.update!(last_editor: current_user.id)
      return true
    end
  end  
  
  def create_action_respond_formatted(format)
    if create_wiki_transaction
      create_action_respond_formatted_for_successful(format)
    else
      create_action_respond_formatted_for_unchanged(format)
    end
  end
  
  def create_wiki_transaction
    Wiki.transaction do
      @project.wikis.create!(wiki_params)
        .update!(creator: current_user.id)
      return true
    end
  end
  
  def create_action_respond_formatted_for_successful(format)
    format.html { redirect_to @project, 
      notice: 'Wiki was successfully created.' }
    format.json { render :show, status: :created, location: @project }
  end
  
  def create_action_respond_formatted_for_unchanged(format)
    format.html { render :new }
    format.json { render json: @project.errors, status: :unprocessable_entity }
  end
  
end
