class Api::V1::SchedulingsController < ApplicationController
  before_action :set_scheduling, only: [:show, :update, :destroy]

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page  = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * limit

    @schedulings = Scheduling.limit(limit).offset(offset).order(start_time: :desc)

    render json: {
      meta: { page: page, per_page: limit, total: Scheduling.count },
      data: @schedulings
    }
  end

  def show
    render json: @scheduling
  end

  def create
    @scheduling = Scheduling.create!(scheduling_params)
    render json: @scheduling, status: :created
  end

  def update
    @scheduling.update!(scheduling_params)
    render json: @scheduling
  end

  def destroy
    @scheduling.destroy!
    head :no_content
  end

  private

  def set_scheduling
    @scheduling = Scheduling.find_by!(uuid: params[:id])
  end

  def scheduling_params
    params.require(:scheduling).permit(:student_id, :professor_id, :course_class_id, :start_time, :end_time, :location, :status)
  end
end
