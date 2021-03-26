class UsersController < ApplicationController
  def index
    render json: User.all, status: 200
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 200
    else
      render_unprocessable_entity(user)
    end
  end

  def login
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }
    else
      render_unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
