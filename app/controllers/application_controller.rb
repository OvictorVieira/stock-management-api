class ApplicationController < ActionController::API

  include Paginator
  include ErrorHandler

  respond_to :json

  acts_as_token_authentication_handler_for User
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
