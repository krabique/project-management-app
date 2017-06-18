class DiscussionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "discussion_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
