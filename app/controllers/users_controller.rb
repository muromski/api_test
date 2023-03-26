# frozen_string_literal: true

# get, create and login
class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      user_json = ActiveModelSerializers::SerializableResource.new(user, { serializer: UserSerializer }).as_json
      render json: user_json, status: 200
    else
      render_unprocessable_entity(user)
    end
  end

  def login
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      user_json = ActiveModelSerializers::SerializableResource.new(user, { serializer: UserSerializer }).as_json
      token = encode_token({ user_id: user.id })
      render json: { user: user_json, token: token }
    else
      render_unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
