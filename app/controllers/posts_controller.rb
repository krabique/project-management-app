class PostsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :discussion, :through => :project
  load_and_authorize_resource :post, :through => :discussion
  before_action :archived?
  skip_before_action :archived?, only: [:show]

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
