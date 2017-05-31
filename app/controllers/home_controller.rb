class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  
  def index
    @projects = Project.all
  end
  
end
