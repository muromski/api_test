# frozen_string_literal: true

# get and create jobs
class JobsController < ApplicationController
  def index
    render_unauthorized and return unless token

    if title
      render json: Job.where(title: title), status: 200
    elsif search_languages
      render json: Job.where("languages LIKE '%#{search_languages}%'"), status: 200
    else
      render json: Job.all, status: 200
    end
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
    params.permit(:title, :salary, :languages, :shifts)
  end
end
