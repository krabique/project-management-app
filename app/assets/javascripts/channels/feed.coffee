App.feed = App.cable.subscriptions.create "FeedChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.action.blank?
      $('#current_feed').removeAttr('id') 
      
      $('#live-feed').prepend '<div class="list-group-item" ' + 
        ' id="current_feed">' +
        data.user + '&nbsp;has '+ data.action + 'd&nbsp;' + data.project +
        '&nbsp;at ' + data.time +
        '</div>'
        
      $('#current_feed').css({'background-color':'#88ff88'})
      $('#current_feed').animate({
      			backgroundColor: "#ffffff"
      	}, 1500 );