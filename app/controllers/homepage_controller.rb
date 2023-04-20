class HomepageController < ApplicationController
  layout 'homepage'

  def index
    @channels = current_user.channels.with_chat_info_ordered
    @q = User.ransack(params[:q])
    @inboxes = current_user.chats.inboxes(current_user)
  end

  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    respond_to do |format|
      format.turbo_stream
      format.html { render :search }
    end
  end

end