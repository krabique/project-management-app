class DiscussionsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :discussion, through: :project
  before_action :archived?
  skip_before_action :archived?, only: [:show]
  
  def new
  end
  
  def create
    if safe_create_discussion
      redirect_to @project, notice: 'Discussion was successfully created.'
    else
      render :new
    end
  end
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    if safe_update_discussion
      redirect_to project_discussion_path(@project, @discussion), 
        notice: 'Discussion was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    Discussion.find(params[:id]).destroy
    redirect_to @project
  end
  
  
  private
  
  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
  
  def safe_update_discussion
    begin
      @discussion.update!( discussion_params.merge(last_editor: 
        current_user.id) )
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end    
  end
  
  def safe_create_discussion
    begin
      @project.discussions.create!(discussion_params.merge(
        creator: current_user.id) )
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end     
  end
  
end
