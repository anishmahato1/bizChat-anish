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

  #   respond_to do |format|
  #     if @chat.save
  #       format.html { redirect_to chat_url(@chat), notice: 'Chat was successfully created.' }
  #       format.json { render :show, status: :created, location: @chat }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @chat.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /chats/1 or /chats/1.json
  # def update
  #   respond_to do |format|
  #     if @chat.update(chat_params)
  #       format.html { redirect_to chat_url(@chat), notice: 'Chat was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @chat }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @chat.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /chats/1 or /chats/1.json
  # def destroy
  #   @chat.destroy

  #   respond_to do |format|
  #     format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def set_chat
    @chat = Chat.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:is_channel, :name)
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
