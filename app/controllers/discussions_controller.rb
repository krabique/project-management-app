class DiscussionsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :discussion, :through => :project
  before_action :archived?
  skip_before_action :archived?, only: [:show]
  
  def new
  end
  
  def create
    if create_discussion_transaction
      redirect_to @project, notice: 'Discussion was successfully created.'
    else
      redirect_to @project, 
        alert: "There was an error creating discussion."
    end
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
