class FeedsController < ApplicationController
  #load_and_authorize_resource :feed
  
  def new
    @feed = Feed.new
  end
  
  def create
    @feed = Feed.new
    if safe_create_feed_post
      #create_feed('post', @feed.body)
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
      create_feed_post_transaction
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end
  
  def create_feed_post_transaction
    Feed.transaction do
      @feed = Feed.new(feed_post_params)
      @feed.save!
      @feed.update!(user_id: current_user.id, action: "post")
      return true
    end
  end
end
