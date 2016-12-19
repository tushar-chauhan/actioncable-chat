module MessagesHelper
  def self_or_other(message)
    message.user == current_user ? 'self' : 'other'
  end

  def message_interlocutor(message)
    puts "Conversation id: #{message.conversation.id}"
    if message.user == message.conversation.user
      message.conversation.user
    else
      message.conversation.recipient
    end
  end
end
