class FeedsController < ApplicationController
  
  def new
    @feed = Feed.new
  end
  
  def create
    @feed = Feed.new
    if safe_create_feed_post
      broadcast_feed(@feed)
      redirect_to root_path, notice: 'Feed post was successfully created.'
    else
      render :new
    end
  end
  
  
  private
  
  def feed_post_params
    params.require(:feed).permit(:body)
  end
  
  def safe_create_feed_post
    begin
      @feed = Feed.create( feed_post_params.merge(
        user_id: current_user.id, action: "post") )
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end
  
end
