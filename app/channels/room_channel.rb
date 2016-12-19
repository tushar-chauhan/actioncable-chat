# Be sure to restart your server when you modify this file. Action Cable runs
# in a loop that does not support auto reloading.

class RoomChannel < ApplicationCable::Channel
  def subscribed
    # puts '* * * Subscribed..'
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # puts '* * * Sending..'
    Message.create!(
      body: data['message'],
      user: current_user,
      conversation_id: data['conversation_id']
    )
  end
end
