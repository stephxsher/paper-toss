class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # around_action :set_time_zone, if: :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :phone]
    devise_parameter_sanitizer.for(:sign_in) << [:first_name, :last_name, :phone]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :phone]
  end

  # private

  # def set_time_zone(&block)
  #   Time.use_zone(current_user.time_zone, &block)
  # end
end
