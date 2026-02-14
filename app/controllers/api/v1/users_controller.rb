class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page  = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @users = User.limit(limit).offset(offset).order(created_at: :desc)

    render json: {
      meta: { page: page, per_page: limit, total: User.count },
      data: @users
    }
  end

  def show
    render json: @user
  end

  def create
    @user = User.create!(user_params)

    render json: @user, status: :created
  end

  def update
    @user.update!(user_params)

    render json: @user
  end

  def destroy
    @user.destroy!

    head :no_content
  end

  private

  def set_user
    @user = User.find_by!(uuid: params[:uuid])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone, :user_type)
  end
end
