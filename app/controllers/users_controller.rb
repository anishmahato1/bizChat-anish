class UsersController < ApplicationController
  def search
    @q = User.ransack(params[:q])
    @users = @q.result.with_attached_avatar.includes(:chats)
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show; end
end
