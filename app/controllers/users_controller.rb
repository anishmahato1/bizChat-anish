class UsersController < ApplicationController
  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).except_current_user(current_user).with_attached_avatar.includes(:chats)
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show
    set_recepient
    if @recepient == current_user
      render turbo_stream: turbo_stream.update('flash', flash.now[:notice] = 'Checked Self')
      return
    end

    set_private_chat_if_exists_else_create

    @messages = Chat.messages_with_image_and_sender_avatar_included(@chat)

    render 'chats/show'
  end

  private

  def create_private_chat_with(recepient)
    Chat.create(users: [recepient, current_user])
  end

  def set_recepient
    @recepient = User.find_by(id: params[:id])
  end

  def set_private_chat_if_exists_else_create
    @chat = Chat.private_chat_between(current_user, @recepient).first
    return @chat if @chat.present?

    @chat = create_private_chat_with(@recepient)
  end
end
