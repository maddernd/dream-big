require 'login_library'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :authenticate_sso_request, except: [:create]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def find_user
    @user = User.find_by_username!(params[:_username])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_sso_request
    token = request.headers['Authorization']
    result = LoginLibrary::Authentication.login_with_sso(token)

    if result[:error]
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
