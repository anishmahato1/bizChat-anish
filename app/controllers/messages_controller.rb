class MessagesController < ApplicationController
  before_action :set_chat, :authenticate_if_user_belongs_to_chat!
  def create
    @message = @chat.messages.new(message_params)
    @message.sender_id = current_user.id

    if @message.save
      remove_contents_from_new_message_form

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image)
  end

  def set_chat
    @chat = Chat.find_by(id: params[:chat_id])
  end

  def authenticate_if_user_belongs_to_chat!
    raise User::NotAuthorized unless @chat.users.include?(current_user)
  end

  def remove_contents_from_new_message_form
    render turbo_stream: turbo_stream.update('messages-new', partial: 'new_message_form',
                                                             locals: { chat: @chat, message: @chat.messages.build })
  end
end
