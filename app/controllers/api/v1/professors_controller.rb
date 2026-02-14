class Api::V1::ProfessorsController < ApplicationController
  before_action :set_professor, only: [ :show, :update, :destroy ]

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @professors = User.where(user_type: "professor").limit(limit).offset(offset).order(:name)

    render json: {
      meta: {
        page: page,
        per_page: limit,
        total: User.where(user_type: "professor").count
      },
      data: @professors
    }
  end

  def show
    render json: @professor
  end

  def create
    professor_attributes = professor_params.merge(user_type: "professor")
    @professor = User.create!(professor_attributes)
    render json: @professor, status: :created
  end

  def update
    @professor.update!(professor_params)
    render json: @professor
  end

  def destroy
    @professor.destroy!
    head :no_content
  end

  private

  def set_professor
    @professor = User.where(user_type: "professor").find_by!(uuid: params[:id])
  end

  def professor_params
    params.require(:professor).permit(:name, :email, :phone, :password)
  end
end
