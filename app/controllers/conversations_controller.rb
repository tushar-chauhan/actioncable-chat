class ConversationsController < ApplicationController
  before_action :authenticate_user!

  layout false

  def create
    if Conversation.between(params[:user_id], params[:recipient_id]).present?
      @conversation = Conversation.between(
        params[:user_id],
        params[:recipient_id]
      ).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end

  private

  def conversation_params
    params.permit(:user_id, :recipient_id)
  end

  def interlocutor(conversation)
    if current_user == conversation.recipient
      conversation.user
    else
      conversation.recipient
    end
  end
end
