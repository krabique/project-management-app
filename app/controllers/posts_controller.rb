class PostsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :discussion, :through => :project
  load_and_authorize_resource :post, :through => :discussion
  before_action :archived?
  skip_before_action :archived?, only: [:show]

  def new
  end
  
  def create
    if create_post_transaction
      broadcast_changes
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
  
  def broadcast_changes
    ActionCable.server.broadcast 'discussion_channel',
      body:  @post.body,
      link_to_user: (view_context.link_to User.find_by_id(@post.creator).name, 
              User.find_by_id(@post.creator)),
      avatar: (view_context.image_tag(User.find_by_id(@post.creator).avatar.url(:thumb),
              :class => "user-thumb-image user-list")),
      creator_name: User.find_by_id(@post.creator).name,
      created_at: @post.created_at.to_s
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
      @post = @discussion.posts.new(post_params)
      @post.save!
      @post.update!(creator: current_user.id)
      return true
    end
  end
  
end
