class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  before_action :authenticate_user!

  attr_reader :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def handle_not_found(e)
    render json: { error: e.message }, status: :not_found
  end

  def handle_invalid_record(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def handle_parameter_missing(e)
    render json: { error: e.message }, status: :bad_request
  end

  def render_error(message, status = :unprocessable_entity)
    render json: { error: message }, status: status
  end

  def authenticate_user!
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last

    return render_error("Token not provided", :unauthorized) unless token

    login_record = Login.find_by(token: token)

    if login_record
      @current_user = login_record.user
    else
      render_error("Unauthorized or Invalid Token", :unauthorized)
    end
  end
end
