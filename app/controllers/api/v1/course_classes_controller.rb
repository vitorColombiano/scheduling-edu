class Api::V1::Professors::CourseClassesController < ApplicationController
  before_action :set_professor

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @course_classes = @professor.course_classes.limit(limit).offset(offset).order(start_time: :desc)

    render json: {
      professor_uuid: @professor.uuid,
      meta: {
        page: page,
        per_page: limit,
        total: @professor.course_classes.count
      },
      data: @course_classes
    }
  end

  private

  def set_professor
    @professor = User.where(user_type: "professor").find_by!(uuid: params[:professor_id])
  end
end
