# App.chatroom = App.cable.subscriptions.create {channel: "ChatroomChannel", room: window.location.pathname.split("/")[3]},
#   connected: ->
#     # Called when the subscription is ready for use on the server

#   disconnected: ->
#     # Called when the subscription has been terminated by the server

#   received: (data) ->
#     $('#messages').append data['message']
#     # Called when there's incoming data on the websocket for this channel

#   speak: (message) ->
#     @perform 'speak', {message: message}

# chatroom_chk id를 이용해서 특정 페이지에서만 액션케이블 작동하도록!!(매우 중요)

$(document).on 'turbolinks:load', -> # use page:change if your on turbolinks < 5
  if document.getElementById("chatroom_chk") # if a specific field is found 
    App.chatroom = App.cable.subscriptions.create {channel: "ChatroomChannel", room: window.location.pathname.split("/")[3]},
        connected: ->
          # Called when the subscription is ready for use on the server
      
        disconnected: ->
          # Called when the subscription has been terminated by the server
      
        received: (data) ->
          $('#messages').append data['message']
          # Called when there's incoming data on the websocket for this channel
      
        speak: (message) ->
          @perform 'speak', {message: message}
  else if App.chatroom
    App.chatroom.unsubscribe()
    App.chatroom = null