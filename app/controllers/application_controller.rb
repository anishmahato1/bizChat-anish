class ApplicationController < ActionController::Base
  rescue_from User::NotAuthorized, with: :user_not_authorized

  include Pagy::Backend
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query_object_for_ransack

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name gender])
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:password, :current_password, :name, :avatar)
    end
  end

  # when user not authorized render flash wit stream or redirect to root path
  def user_not_authorized
    message = 'You are not authorized'
    flash.now[:alert] = message
    respond_to do |format|
      format.turbo_stream { display_flash_with_turbo_stream }
      format.html { redirect_to root_path, status: :see_other, alert: message }
    end
  end

  def display_flash_with_turbo_stream
    render turbo_stream: turbo_stream.prepend('flash', partial: 'shared/flash')
  end

  def set_query_object_for_ransack
    @q = User.ransack(params[:q])
  end
end
