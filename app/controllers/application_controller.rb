class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
