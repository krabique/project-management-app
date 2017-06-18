App.discussion = App.cable.subscriptions.create "DiscussionChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.body.blank?
      if $('#' + data.discussion_id + '-posts-table-tbody').length is 0
        location.reload();
      else
        $('#' + data.discussion_id + '-posts-table-tbody').append '<tr>' + '<td>' +
          data.avatar + data.link_to_user + ' posted at ' + data.created_at +
          '<div class="panel panel-default">' +
          '<div class="panel-body">' + data.body +
          '</div>' +
          '</div>' + '<td></td>' +
          '</tr>' +
          '</td>'
