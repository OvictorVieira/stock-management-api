class ApplicationController < ActionController::API

  respond_to :json

  include Paginator
  include ErrorHandler

  acts_as_token_authentication_handler_for Store
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::ParameterMissing do |parameter_missing_exception|

    error = {}

    error[parameter_missing_exception.param] = [I18n.t('errors.messages.empty')]

    render json: { errors: [error] }, status: :unprocessable_entity
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address])
  end
end
