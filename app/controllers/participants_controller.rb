class ParticipantsController < ApplicationController
  include ParticipantsHelper
  before_action :set_channel
  before_action :authorization_for_index, on: :index
  before_action :authorization_for_add_remove, on: %i[add remove]

  def index
    @participants = @channel.chat.users
  end

  def add; end

  def remove; end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:channel_id])
  end

  # If the user is not authorized, raise exception
  def authorization_for_add_remove
    raise User::NotAuthorized unless admin?
  end

  def authorization_for_index
    raise User::NotAuthorized unless @channel.chat.users.include?(current_user)
  end
end
