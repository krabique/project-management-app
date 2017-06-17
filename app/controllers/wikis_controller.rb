class WikisController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :wiki, :through => :project
  before_action :archived?
  skip_before_action :archived?, only: [:show]
  
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
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    if update_wiki_transaction
      redirect_to project_wiki_path(@project, @wiki), notice: 'Wiki was successfully updated.'
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
