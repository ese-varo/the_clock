class ApplicationController < ActionController::Base
  before_action :configure_permitted_parametters, if: :devise_controller?

  protected

  def configure_permitted_parametters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
