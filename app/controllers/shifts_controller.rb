class ShiftsController < ApplicationController

  def index
    render_unauthorized and return unless token

    render json: Shift.all, status: 200
  end

  def create
    render_unauthorized and return unless token
    shift = Shift.new(shift_params)

    if shift.save
      render json: shift, status: 200
    else
      render_unprocessable_entity(shift)
    end
  end

  private

  def shift_params
    params.permit(:start_date, :finish_date, :job_id)
  end
end
