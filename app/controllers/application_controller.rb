class ApplicationController < ActionController::API
  def render_unprocessable_entity(entity)
    render json: { error: 'Unprocessable entity', error_messages: entity.errors }, status: :unprocessable_entity
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: 401
  end

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t') # TODO: set secret for prod
  end

  def token
    params[:token].presence
  end

end
