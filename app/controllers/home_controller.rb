class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  
  def index
    @projects = Project.all.limit(10).order(created_at: :desc)
    @feeds = Feed.includes(:user, :project).all
    @users = User.all
    p "----start--home_controller ---- current_user ---"
    if current_user
      p "----finish--home_controller ---- current_user ---"
      @my_projects = current_user.projects
    end
  end
  
end
