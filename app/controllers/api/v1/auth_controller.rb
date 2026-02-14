class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login, :register]

  def login
    login = Login.find_by(email: params[:email])
    if login && BCrypt::Password.new(login.password_hash) == params[:password]
      token = generate_jwt_token(login.user)
      login.update(token: token)
      render json: { token: token, user: login.user.as_json(only: [:id, :uuid, :name, :phone, :user_type]) }
    else
      render_error("Invalid credentials", :unauthorized)
    end
  end

  def register
    user = User.new(user_params.except(:password, :email))
    login = Login.new(email: params[:user][:email], password_hash: BCrypt::Password.create(params[:user][:password]), user: user)
    if user.save && login.save
      token = generate_jwt_token(user)
      login.update(token: token)
      render json: { token: token, user: user.as_json(only: [:id, :uuid, :name, :phone, :user_type]) }, status: :created
    else
      render_error(user.errors.full_messages.concat(login.errors.full_messages).join(", "))
    end
  end

  def logout
    current_user&.login&.update(token: nil)
    render json: { message: "Logged out" }
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :user_type, :email, :password)
  end

  def generate_jwt_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
