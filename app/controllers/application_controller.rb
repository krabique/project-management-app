class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  protected
  
  def authorized?
    unless (can? :manage, Project) || 
      current_user.projects.find_by_id(@project)
      redirect_to project_or_root_pathes, alert: "Know your place, mere dev!"
      return false
    else
      return true
    end
  end
  
  def project_or_root_pathes
    @project.nil? ? root_path : @project
  end
  
  def create_cloudinary_link
    if params[:image_id].present?
      preloaded_cloudinary = Cloudinary::PreloadedFile.new(params[:image_id])
      raise "Invalid upload signature" if !preloaded_cloudinary.valid?
      return preloaded_cloudinary
    else
      return false
    end
  end
  
end
