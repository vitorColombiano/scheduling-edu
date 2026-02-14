class Api::V1::Professors::SchedulingsController < ApplicationController
  before_action :set_professor

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @schedulings = @professor.professor_schedulings.limit(limit).offset(offset).order(start_time: :desc)

    render json: {
      professor_uuid: @professor.uuid,
      meta: {
        page: page,
        per_page: limit,
        total: @professor.professor_schedulings.count
      },
      data: @schedulings
    }
  end

  private

  def set_professor
    @professor = User.where(user_type: "professor").find_by!(uuid: params[:professor_id])
  end
end
