class ChannelsController < ApplicationController
  def show; end

  def create
    channel=
end

  def destroy; end

  private
      # Only allow a list of trusted parameters through.
      def channels_params
        params.require(:channel).permit(:name, :description)
      end
end
