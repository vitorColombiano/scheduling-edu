class Api::V1::StudentsController < ApplicationController
  before_action :set_student, only: [ :show, :update, :destroy ]

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page  = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @students = User.where(user_type: "student").limit(limit).offset(offset).order(:name)

    render json: {
      meta: {
        page: page,
        per_page: limit,
        total: User.where(user_type: "student").count
      },
      data: @students
    }
  end

  def show
    render json: @student
  end

  def create
    student_attributes = student_params.merge(user_type: "student")

    @student = User.create!(student_attributes)

    render json: @student, status: :created
  end

  def update
    @student.update!(student_params)
    render json: @student
  end

  def destroy
    @student.destroy!
    head :no_content
  end

  private

  def set_student
    @student = User.where(user_type: "student").find_by!(uuid: params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :phone, :password)
  end
end
