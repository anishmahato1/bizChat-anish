class ParticipantsController < ApplicationController
  include ParticipantsHelper
  before_action :set_channel, :set_participants
  before_action :authorization_for_index, only: :index
  before_action :authorization_for_add_remove, :set_user, only: %i[add remove]

  def index; end

  def search
    @users = @q.result(distinct: true).where.not(id: @participants.pluck(:id)).with_attached_avatar
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def add
    if @participants.include?(@user)
      flash.now[:notice] = 'Already a Participant'
    else
      @participants << @user
      flash.now[:success] = 'Added Successfully'
    end
  end

  def remove
    if @user == @channel.admin
      flash.now[:alert] = 'Cannot remove Admin!'
      display_flash_with_turbo_stream
      return
    end
    @participants.delete(@user)
    flash.now[:alert] = 'Removed Successfully'
  end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:channel_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  # If the user is not authorized, raise exception
  def authorization_for_add_remove
    raise User::NotAuthorized unless admin?
  end

  # checks if user is participant for index action
  def authorization_for_index
    return if @channel.chat.users.include?(current_user)

    raise User::NotAuthorized
  end

  def set_participants
    @participants = @channel.chat.users
  end
end
