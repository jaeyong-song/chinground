$(document).on 'turbolinks:load', -> # use page:change if your on turbolinks < 5
  if document.getElementById("freechat_chk") # if a specific field is found 
    App.freechat = App.cable.subscriptions.create {channel: "FreechatChannel", room: window.location.pathname.split("/")[3]},
        connected: ->
          # Called when the subscription is ready for use on the server
      
        disconnected: ->
          # Called when the subscription has been terminated by the server
      
        received: (data) ->
          $('#messages').append data['message']
          # Called when there's incoming data on the websocket for this channel
      
        speak: (message) ->
          @perform 'speak', {message: message}
  else if App.freechat
    App.freechat.unsubscribe()
    App.freechat = null