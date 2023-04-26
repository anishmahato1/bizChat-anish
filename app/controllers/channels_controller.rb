class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def create
    @chat = Chat.new(is_channel: true)
    @channel = @chat.build_channel(channels_params)

    set_admin_and_include_in_users

    if @channel.save
      render :new, status: :unprocessable_entity
    else
      render :create, flash.now[:notice] = 'Channel Created Successfully!'
    end
  end

  def destroy; end

  private

  # Only allow a list of trusted parameters through.
  def channels_params
    params.require(:channel).permit(:name, :description)
  end

  def set_admin_and_include_in_users
    @channel.admin = current_user
    @chat.users << @channel.admin
  end
end
