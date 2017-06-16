class PostsController < ApplicationController
  before_action :set_post, 
    only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_discussion, 
    only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_project, 
    only: [:show, :edit, :update, :destroy, :new, :create]
  load_and_authorize_resource
  before_action :archived?, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end
  
  def create
    if create_post_transaction
      redirect_to project_discussion_path(@project, @discussion), notice: 'Post was successfully created.'
    else
      redirect_to new_project_post(@discussion), 
        alert: "There was an error creating post."
    end
  end
  
  def index
    @posts = Post.all
  end
  
  def show
    @users = User.all
  end
  
  def edit
  end
  
  def update
    if update_post_transaction
      redirect_to project_discussion_path(@project, @discussion), notice: 'Post was successfully updated.'
    else
      redirect_to edit_project_post(@project, @post), 
        alert: 'There was an error updating post.'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to project_discussion_path(@project, @discussion)
  end
  
  
  private
  
  def set_project
    unless @project = @discussion.project
      @project = Project.find_by(id: params[:project_id])
    end
  end
  
  def set_discussion
    unless @discussion = Discussion.find_by(id: params[:discussion_id])
      @discussion = Discussion.new
    end
  end
  
  def set_post
    unless @post = Post.find_by(id: params[:id])
      @post = Post.new
    end
  end
  
  def post_params
    params.require(:post).permit(:body)
  end
  
  def update_post_transaction
    Document.transaction do
      @post.update!(post_params)
      @post.update!(last_editor: current_user.id)
      return true
    end
  end
  
  def create_post_transaction
    Post.transaction do
      @discussion.posts.create!(post_params)
                       .update!(creator: current_user.id)
      return true
    end
  end
  
end
