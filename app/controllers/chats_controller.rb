class ChatsController < ApplicationController
  layout 'homepage'
  before_action :set_chat, :authenticate_if_user_belongs_to_chat!, only: :show

  def index
    @channels = current_user.channels
    @q = User.ransack(params[:q])
    @inboxes = User.inboxes(current_user)
  end

  def show
    set_recepient_info unless @chat.is_channel
    @messages = Chat.messages_with_image_and_sender_avatar_included(@chat)
  end

  private

  def set_chat
    @chat = Chat.find_by(id: params[:id])
  end

  # to show recepient info for private chat in right panel
  def set_recepient_info
    @recepient = @chat.users.except_current_user(current_user).with_attached_avatar.first
  end

  # to prevent unauthorized user from others chat
  def authenticate_if_user_belongs_to_chat!
    raise User::NotAuthorized unless @chat.users.include?(current_user)
  end
end
