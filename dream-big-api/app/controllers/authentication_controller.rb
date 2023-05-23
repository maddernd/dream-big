module LoginLibrary
  class Authentication
    def self.login(email, password)
      user = User.find_by_email(email)
      if user&.authenticate(password)
        token = jwt_encode(user_id: user.id)
        { token: token }
      else
        { error: 'unauthorized' }
      end
    end

    def self.sso_login(sso_token)
      user_info = SSO.verify(sso_token)
      user = User.find_by_email(user_info[:email])
      unless user
        user = User.create(email: user_info[:email], username: user_info[:username])
      end

      token = jwt_encode(user_id: user.id)
      { token: token }
    end
  end
end


class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # POST /auth/login
  def login
    result = LoginLibrary::Authentication.login(params[:email], params[:password])
    if result[:token]
      render json: { token: result[:token] }, status: :ok
    else
      render json: { error: result[:error] }, status: :unauthorized
    end
  end

  # POST /auth/sso_login
  def sso_login
    result = LoginLibrary::Authentication.sso_login(params[:sso_token])
    if result[:token]
      render json: { token: result[:token] }, status: :ok
    else
      render json: { error: result[:error] }, status: :unauthorized
    end
  end
end
