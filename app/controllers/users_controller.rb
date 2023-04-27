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
      flash[:notice] = 'This is You!'
      redirect_to chats_path
    else
      set_private_chat_if_exists_else_create
      redirect_to chat_path(@chat), status: :see_other
    end
  end

  private

  # set recepient for private chat to show their info
  def set_recepient
    @recepient = User.find_by(id: params[:id])
  end

  # finds private chat if already exist between users else create
  def set_private_chat_if_exists_else_create
    @chat = Chat.private_chat_between(current_user, @recepient).first || Chat.create(users: [@recepient, current_user])
  end
end
