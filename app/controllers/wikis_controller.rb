class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :new, :create]
  load_and_authorize_resource

  def new
    @wiki = Wiki.new
  end
  
  def create
    if create_wiki_transaction
      redirect_to @project, notice: 'Wiki was successfully created.'
    else
      redirect_to new_project_wiki(@project), 
        alert: "There was an error creating wiki."
    end
  end
  
  def index
    @wikis = Wiki.all
  end
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    if update_wiki_transaction
      redirect_to @wiki.project, notice: 'Wiki was successfully updated.'
    else
      redirect_to edit_project_wiki(@project, @wiki), 
        alert: 'There was an error updating wiki.'
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    @wiki.destroy
    redirect_to @project
  end
  
  
  private
  
  def set_project
    unless @project = @wiki.project
      @project = Project.find_by(id: params[:project_id])
    end
  end
  
  def set_wiki
    unless @wiki = Wiki.find_by(id: params[:id])
      @wiki = Wiki.new
    end
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
  
  def update_wiki_transaction
    Document.transaction do
      @wiki.update!(wiki_params)
      @wiki.update!(last_editor: current_user.id)
      return true
    end
  end
  
  def create_wiki_transaction
    Wiki.transaction do
      @project.wikis.create!(wiki_params)
                    .update!(creator: current_user.id)
      return true
    end
  end
  
end
