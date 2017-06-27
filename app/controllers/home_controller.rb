class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_tag_counts, only: :index
  
  def index
    @projects = Project.all.limit(10).order(created_at: :desc)
    @feeds = Feed.includes(:user, :project).all
    @users = User.all
    if current_user
      @my_projects = current_user.projects
    end
  end
  
end
