require 'grape'

class AuthenticationApi < Grape::API
  helpers AuthenticationHelpers
  helpers JwtHelpers

  desc 'Authentication method configuration'
  get '/authentication/method' do
    response = {
      method: DreamBig_Api::Application.config.auth_method
    }

    present response, with: Grape::Presenters::Presenter
  end

  # To sign in:
  # When AAF and SAML not used, the database acts as the default login mechanism
  if AuthenticationHelpers.db_auth?
    desc 'Authentication login process'
    params do
      requires :email, type: String, desc: 'User\' email'
      requires :password, type: String, desc: 'User\'s password'
    end
    post '/authentication/login' do
      @user = User.find_by_email(params[:email])
      doesUserDetailsMatchPayload = @user&.authenticate(params[:password])

      if doesUserDetailsMatchPayload
        token = JwtHelpers.jwt_encode(user_id: @user.id)
        response = { token: token }
        present response, with: Grape::Presenters::Presenter
      else
        error!({ error: 'Invalid email or password'}, 401)
      end
    end
  end
end
