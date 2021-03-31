class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: %i[auto_login]

  def index
    @users = User.all
    render json: @users, status: 200
  end
  # REGISTER

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { status: :created, user: @user, token: token }
    else
      render json: { error: 'Invalid name or password' }
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { status: :logged_in, user: @user, token: token, loggedIn: true }
    else
      render json: { error: 'Invalid name or password', loggedIn: false }
    end
  end

  def auto_login
    # @user = User.find_by(email: params[:email])
    render json: { user: @user, loggedIn: true }
  end

  def logout
    reset_session
    render json: { logged_out: true }, status: :ok
  end

  private

  def user_params
    params.permit(:name, :password, :password_confirmation, :email, :global_balance, :outgoing_transactions, :incoming_transactions)
  end
end
