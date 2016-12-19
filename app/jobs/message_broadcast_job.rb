class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    puts "Message in perform: #{message}"

    ActionCable.server.broadcast(
      'room_channel',
      message: render_message(message),
      sender_id: message.user.id,
      recipient_id: message.user.id == message.conversation.user_id ? message.conversation.recipient_id : message.conversation.user_id,
      conversation_id: message.conversation.id
    )
  end

  private

  def render_message(message)
    puts 'In render_message.....'
    puts "Message: #{message.user.name}"

    ApplicationController.render_with_signed_in_user(
      message.user,
      partial: 'messages/message',
      locals: { message: message }
    )
  end
end
