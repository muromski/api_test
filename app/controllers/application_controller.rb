# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_unprocessable_entity(entity)
    render json: { error: 'Unprocessable entity', error_messages: entity.errors }, status: :unprocessable_entity
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: 401
  end

  def render_not_unique_job_application
    render json: { error: 'Not unique job_application!' }
  end

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t') # TODO: set secret for prod
  end

  def token
    params[:token].presence
  end

  def decoded_token
    return unless token

    begin
      JWT.decode(token, 's3cr3t', true, algorithm: 'HS256') # TODO: make secret in ENV vars
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token

    decoded_token[0]['user_id']
  end

  def job_id
    params[:job_id].presence
  end

  def title
    params[:title].presence
  end

  def search_languages
    params[:languages].presence
  end
end
