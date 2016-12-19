App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'Connected..'

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log 'Disconnected..'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log "Received: ", data
    message = data['message']
    sender_id = data['sender_id']
    recipient_id = data['recipient_id']
    reciever_id = parseInt $('meta[name=user-id]').attr("content")
    if reciever_id == recipient_id || sender_id == reciever_id
      conversation_id = data['conversation_id']
      chatbox = $("#chatbox_" + conversation_id + " .chatboxcontent")

      chatBox.chatWith(conversation_id)
      chatbox.append(message)
      if sender_id != reciever_id
        chatbox.children().last().removeClass("self").addClass("other")
        chatBox.notify()

      chatbox.scrollTop(chatbox[0].scrollHeight) if chatbox[0]
      return
    return

  send_message: (message, conversation_id) ->
    @perform 'send_message', message: message, conversation_id: conversation_id
