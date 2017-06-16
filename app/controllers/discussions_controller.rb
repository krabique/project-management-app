class DiscussionsController < ApplicationController
  before_action :set_discussion, 
    only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_project, 
    only: [:show, :edit, :update, :destroy, :new, :create]
  load_and_authorize_resource
  before_action :archived?, only: [:new, :create, :edit, :update, :destroy]

  def new
    @discussion = Discussion.new
  end
  
  def create
    if create_discussion_transaction
      redirect_to project_discussion_path(@project, @discussion), notice: 'Discussion was successfully created.'
    else
      redirect_to project_discussion_path(@project, @discussion), 
        alert: "There was an error creating discussion."
    end
  end
  
  def index
    @discussions = Discussion.all
  end
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    if update_discussion_transaction
      redirect_to project_discussion_path(@project, @discussion), notice: 'Discussion was successfully updated.'
    else
      redirect_to edit_project_discussion_path(@project, @discussion), 
        alert: 'There was an error updating discussion.'
    end
  end
  
  def destroy
    @discussion = Discussion.find(params[:id])
    @discussion.destroy
    redirect_to @project
  end
  
  
  private
  
  def set_project
    unless @project = @discussion.project
      @project = Project.find_by(id: params[:project_id])
    end
  end
  
  def set_discussion
    unless @discussion = Discussion.find_by(id: params[:id])
      @discussion = Discussion.new
    end
  end
  
  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
  
  def update_discussion_transaction
    Document.transaction do
      @discussion.update!(discussion_params)
      @discussion.update!(last_editor: current_user.id)
      return true
    end
  end
  
  def create_discussion_transaction
    Discussion.transaction do
      @project.discussions.create!(discussion_params)
                    .update!(creator: current_user.id)
      return true
    end
  end
  
end
