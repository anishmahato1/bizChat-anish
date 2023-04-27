class ChannelsController < ApplicationController
  include ParticipantsHelper
  before_action :set_channel, only: %i[edit update destroy]
  before_action :authenticate_admin!, only: %i[update destroy]

  def new
    @channel = Channel.new
  end

  def create
    @chat = Chat.new(is_channel: true)
    @channel = @chat.build_channel(channel_params)

    set_admin_and_include_in_users

    if @channel.save
      redirect_to chat_path(@channel.chat), status: :see_other, notice: 'Channel Created Successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @channel.update(channel_params)
      redirect_to chat_path(@channel.chat), status: :see_other, notice: 'Channel Updated Successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:name, :description)
  end

  def set_admin_and_include_in_users
    @channel.admin = current_user
    @chat.users << @channel.admin
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def authenticate_admin!
    raise User::NotAuthorized unless admin?
  end
end
