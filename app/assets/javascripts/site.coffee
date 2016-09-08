ready = ->
  $(".start-conversation").click (e) ->
    e.preventDefault()
    sender_id = $(this).data('sid')
    recipient_id = $(this).data('rid')
    $.ajax
      url: '/conversations'
      type: 'POST'
      data:
        user_id: sender_id
        recipient_id: recipient_id
      success: (data, status, response) ->
        chatBox.chatWith(data.conversation_id)
      error: ->
        console.log "error occurred"

  $(document).on "click", ".toggleChatBox", (e) ->
    e.preventDefault()
    console.log "testing click"
    id = $(this).data('cid')
    chatBox.toggleChatBoxGrowth(id)

  $(document).on "click", ".closeChat", (e) ->
    e.preventDefault()
    id = $(this).data('cid')
    chatBox.close(id)

  $(document).on "keydown", ".chatboxtextarea", (e) ->
    id = $(this).data('cid')
    chatBox.checkInputKey(e, $(this), id)

  $('a.conversation').click (e) ->
    e.preventDefault()
    conversation_id = $(this).data('cid')
    chatBox.chatWith(conversation_id)

$(document).on 'turbolinks:load', ->
  ready()
