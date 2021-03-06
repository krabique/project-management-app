class PostsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :discussion, through: :project
  load_and_authorize_resource :post, through: :discussion
  before_action :archived?, except: :show

  def new
  end
  
  def create
    if safe_create_post
      broadcast_create
    else
      render :new
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
    if safe_update_post
      render :js => "window.location = '#{project_discussion_path(@project, 
        @discussion)}'", notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to project_discussion_path(@project, @discussion)
  end
  
  
  private
  
  def broadcast_create
    ActionCable.server.broadcast 'discussion_channel',
      body:  view_context.markdown(@post.body),
      link_to_user: (view_context.link_to @post.user.name, @post.user),
      avatar: ( view_context.image_tag(@post.user.avatar.url(
              :thumb), :class => "user-thumb-image user-list") ),
      creator_name: @post.user.name,
      created_at: @post.created_at.to_s,
      discussion_id: @discussion.id,
      odd_or_even: @discussion.posts.count
    head :ok
  end
  
  def post_params
    params.require(:post).permit(:body)
  end
  
  def safe_update_post
    begin
      @post.update!(post_params.merge(last_editor: current_user.id) )
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end    
  end
  
  def safe_create_post
    begin
      @post = @discussion.posts.create!( post_params.merge(
        creator: current_user.id) )
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end     
  end  
  
end
