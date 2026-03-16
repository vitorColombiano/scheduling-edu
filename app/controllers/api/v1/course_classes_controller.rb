class Api::V1::CourseClassesController < ApplicationController
  before_action :set_course_class, only: [:show, :update, :destroy]

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page  = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @course_classes = CourseClass.limit(limit).offset(offset).order(start_time: :desc)

    render json: {
      meta: { page: page, per_page: limit, total: CourseClass.count },
      data: @course_classes
    }
  end

  def show
    render json: @course_class
  end

  def create
    @course_class = CourseClass.create!(course_class_params)
    render json: @course_class, status: :created
  end

  def update
    @course_class.update!(course_class_params)
    render json: @course_class
  end

  def destroy
    @course_class.destroy!
    head :no_content
  end

  private

  def set_course_class
    @course_class = CourseClass.find_by!(uuid: params[:id])
  end

  def course_class_params
    params.require(:course_class).permit(:product_id, :professor_id, :start_time, :end_time, :status)
  end
end
