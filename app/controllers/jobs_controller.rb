class JobsController < ApplicationController
  def index
    render_unauthorized and return unless token

    render json: Job.all, status: 200
  end

  def create
    render_unauthorized and return unless token

    job = Job.new(job_params)

    if job.save
      job_json = ActiveModelSerializers::SerializableResource.new(job, { serializer: JobSerializer }).as_json
      render json: { job: job_json, token: token }
    else
      render_unprocessable_entity(job)
    end
  end

  private

  def job_params
    params.permit(:title, :salary, :languages, :shift)
  end
end
