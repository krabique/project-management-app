class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  protected
  
  def create_cloudinary_link
    if params[:image_id].present?
      preloaded_cloudinary = Cloudinary::PreloadedFile.new(params[:image_id])
      raise "Invalid upload signature" if !preloaded_cloudinary.valid?
      return preloaded_cloudinary
    else
      return false
    end
  end
  
  def archived?(archived_param=nil)
    if @project.archived
      if archived_param != "0"
        redirect_to @project, alert: "This project is archived!" 
      end
    end
  end
  
  def create_feed(action, body=nil)
    feed = Feed.new
    feed.user_id = current_user.id
    feed.action = action
    feed.project = (@project.id if @project)
    feed.body = body
    
    if feed.save!
      broadcast_feed(feed)
    end
  end
  
  def broadcast_feed(feed)
    ActionCable.server.broadcast 'feed_channel',
      user:     ( view_context.link_to User.find_by_id(feed.user_id).name,
                User.find_by_id(feed.user_id) ),
      action:   feed.action,
      project:  ( view_context.link_to Project.find_by_id(
                feed.project).title, 
                Project.find_by_id(feed.project) if feed.project),
      time:     feed.created_at.to_s,
      body:     feed.body    
  end
  
  private
  
  def current_ability
    @current_ability ||= Ability.new(current_user, params[:project_id])
  end

  def set_tag_counts
    @tag_counts = Project.all.tag_counts
  end
  
end
