# frozen_string_literal: true

# get and create responses
# переименовать в job_applications
class JobApplicationsController < ApplicationController
  def create
    render_unauthorized and return unless token

    job_application = JobApplication.new(job_application_params)
    if job_application.save
      job_application_json = ActiveModelSerializers::SerializableResource.new(job_application,
                                                                       { serializer: JobApplicationSerializer }).as_json
      render json: job_application_json, status: 200
    elsif !params[:job_id]
      render_unprocessable_entity(job_application)
    end
  end

  private

  def job_application_params
    params[:user_id] = logged_in_user
    params[:job_id] = job_id
    render_not_unique_job_application and return if JobApplication.where(user_id: logged_in_user,
                                                            job_id: job_id).size.positive? && params[:job_id]

    params.permit(:user_id, :job_id)
  end
end
