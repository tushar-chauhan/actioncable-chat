# Chat box creation/animation etc. is inspired by anantgarg.com
# http://anantgarg.com/2009/05/13/gmail-facebook-style-jquery-chat/

root = exports ? this
root.chatboxFocus = []
root.chatBoxes = []

ready = () ->
  console.log 'Loaded ready()'
  root.chatBox =
    chatWith: (conversation_id) ->
      chatBox.createChatBox conversation_id
      $("#chatbox_" + conversation_id + " .chatboxtextarea").focus()
      return

    close: (conversation_id) ->
      $('#chatbox_' + conversation_id).css('display', 'none')
      chatBox.restructure()
      return

    notify: () ->
      audioplayer = $('#chatAudio')[0]
      audioplayer.play()
      return

    restructure: () ->
      align = 0
      for x of chatBoxes
        x = x
        chatbox_id = chatBoxes[x]
        if $('#chatbox_' + chatbox_id).css('display') != 'none'
          if align == 0
            $('#chatbox_' + chatbox_id).css 'right', '20px'
          else
            width = align * (280 + 7) + 20
            $('#chatbox_' + chatbox_id).css 'right', width + 'px'
          align++
      return

    createChatBox: (conversation_id, minimizeChatBox) ->
      if $("#chatbox_" + conversation_id).length > 0
        if $("#chatbox_" + conversation_id).css('display') == 'none'
          $("#chatbox_" + conversation_id).css('display', 'block')
          chatBox.restructure()

        $("#chatbox_" + conversation_id + " .chatboxtextarea").focus()
        return

      $("body").append(
        '<div id="chatbox_' + conversation_id + '" class="chatbox"></div>'
      )

      $.get(
        "conversations/" + conversation_id,
        ((data) ->
          $('#chatbox_' + conversation_id).html(data)
          $("#chatbox_" + conversation_id + " .chatboxcontent")
            .scrollTop($("#chatbox_" + conversation_id + " .chatboxcontent")[0]
              .scrollHeight)
          return
        ),
        "html"
      )

      $("#chatbox_" + conversation_id).css('bottom', '0px')

      chatBoxeslength = 0

      for x of chatBoxes
        x = x
        if $('#chatbox_' + chatBoxes[x]).css('display') != 'none'
          chatBoxeslength++

      if chatBoxeslength == 0
        $("#chatbox_" + conversation_id).css('right', '20px')
      else
        width = chatBoxeslength * (280 + 7) + 20
        $("#chatbox_" + conversation_id).css('right', width + 'px')

      chatBoxes.push conversation_id

      if minimizeChatBox == 1
        minimizedChatBoxes = []

        if $.cookie('chatbox_minimized')
          minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/)

        minimize = 0

        j = 0
        while j < minimizedChatBoxes.length
          if minimizedChatBoxes[j] == conversation_id
            minimize = 1
          j++

        if minimize == 1
          $('#chatbox_' + conversation_id + ' .chatboxcontent')
            .css('display', 'none')
          $('#chatbox_' + conversation_id + ' .chatboxinput')
            .css('display', 'none')

      chatboxFocus[conversation_id] = false

      $("#chatbox_" + conversation_id + " .chatboxtextarea").blur(() ->
        chatboxFocus[conversation_id] = false
        $("#chatbox_" + conversation_id + " .chatboxtextarea")
          .removeClass('chatboxtextareaselected')
        return
      ).focus(() ->
        chatboxFocus[conversation_id] = true
        $('#chatbox_' + conversation_id + ' .chatboxhead')
          .removeClass('chatboxblink')
        $("#chatbox_" + conversation_id + " .chatboxtextarea")
          .addClass('chatboxtextareaselected')
        return
      )

      $("#chatbox_" + conversation_id).click(() ->
        if $('#chatbox_' + conversation_id + ' .chatboxcontent')
            .css('display') != 'none'
          $("#chatbox_" + conversation_id + " .chatboxtextarea").focus()
          return
      )

      $("#chatbox_" + conversation_id).show()
      return


    checkInputKey: (event, chatboxtextarea, conversation_id) ->
      if event.keyCode == 13 && !event.shiftKey
        event.preventDefault()

        message = chatboxtextarea.val()
        message = message.replace(/^\s+|\s+$/g, "")

        if message != ''
          App.room.send_message message, conversation_id

          $(chatboxtextarea).val('')
          $(chatboxtextarea).focus()
          $(chatboxtextarea).css('height', '44px')

      adjustedHeight = chatboxtextarea.clientHeight
      maxHeight = 94

      if maxHeight > adjustedHeight
        adjustedHeight = Math.max(chatboxtextarea.scrollHeight, adjustedHeight)
        if maxHeight
          adjustedHeight = Math.min(maxHeight, adjustedHeight)
        if (adjustedHeight > chatboxtextarea.clientHeight)
          $(chatboxtextarea).css('height', adjustedHeight + 8 + 'px')
          return
      else
        $(chatboxtextarea).css('overflow', 'auto')
        return


    toggleChatBoxGrowth: (conversation_id) ->
      if $('#chatbox_' + conversation_id + ' .chatboxcontent')
          .css('display') == 'none'

        minimizedChatBoxes = new Array()

        if $.cookie('chatbox_minimized')
          minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/)

        newCookie = ''

        i = 0
        while i < minimizedChatBoxes.length
          if minimizedChatBoxes[i] != conversation_id
            newCookie += conversation_id + '|'
          i++

        newCookie = newCookie.slice(0, -1)

        $.cookie('chatbox_minimized', newCookie)
        $('#chatbox_' + conversation_id + ' .chatboxcontent')
          .css('display', 'block')
        $('#chatbox_' + conversation_id + ' .chatboxinput')
          .css('display', 'block')
        $("#chatbox_" + conversation_id + " .chatboxcontent")
          .scrollTop($("#chatbox_" + conversation_id + " .chatboxcontent")[0]
            .scrollHeight)
        return
      else
        newCookie = conversation_id

        if $.cookie('chatbox_minimized')
          newCookie += '|' + $.cookie('chatbox_minimized')

        $.cookie('chatbox_minimized', newCookie)
        $('#chatbox_' + conversation_id + ' .chatboxcontent')
          .css('display', 'none')
        $('#chatbox_' + conversation_id + ' .chatboxinput')
          .css('display', 'none')
        return

$(document).on("turbolinks:load", ready)
