require 'grape'
require 'json'
require 'json/jwt'

class AuthenticationApi < Grape::API
  helpers AuthenticationHelpers
  helpers JwtHelpers

  desc 'Authentication method configuration'
  get '/authentication/method' do
    response = {
      method: DreamBig_Api::Application.config.auth_method
    }
    response[:redirect_to] =
      if AuthenticationHelpers.aaf_auth?
        DreamBig_Api::Application.config.aaf[:redirect_url]
      end

    present response, with: Grape::Presenters::Presenter
  end

  # Provides temporary authentication JWT based on logging in from AAF Rapid Connect
  # Will create a user account based on the JWT provided by AAF and then we'll manage the login
  # tokens locally.
  if AuthenticationHelpers.aaf_auth?
    desc 'AAF Rapid Connect JWT callback'
    params do
      requires :assertion, type: String, desc: 'AAF Rapid Connect payload'
    end
    post '/authentication/jwt' do
      jws = params[:assertion]
      error!({ error: 'JWS was not found in the request'}, 500) unless jws

      # Decode JWS
      jwt = JSON::JWT.decode(jws.to_s, DreamBig_Api::Application.config.aaf["secret_decoder"])
      error!({ error: 'Invalid JWS.' }, 500) unless jwt

      # Ensure JWT is a valid AAF token that can be used
      error!({ error: 'Invalid JWT.' }, 500) unless User.is_valid_aaf_jwt(jwt)
      
      # User lookup via unique login id, since this is the only authentication method
      # AAF handles the unique ids
      attrs = jwt['https://aaf.edu.au/attributes']
      email = attrs[:mail]

      # TODO: Migrate username lookup to login_id (lowercase usernames)
      username = email.split('@').first
      user = User.find_by(username: username) ||
        User.find_by(email: email) ||
        User.find_or_create_by(username: username) do |new_user|
          new_user.email      = email
          new_user.username   = username
        end

      # Set username if not yet specified
      user.username = username if user.username.nil?

      # Try and save the user once authenticated if new
      if user.new_record?
        user.password = BCrypt::Password.create(SecureRandom.hex(32))
        unless user.valid?
          error!(error: 'There was an error creating your account in DreamBig. ' \
                        'Please get in contact with your unit convenor or the ' \
                        'DreamBig administrators.')
        end
        user.save
      end

      User.generate_token(user)

      # TODO: Add https for production environment (using callback environment variable)
      host = 'http://localhost:4200'

      redirect "#{host}/login?authToken=#{user.auth_token}&username=#{user.username}"
    end

    desc 'Authentication login process'
    params do
      requires :username, type: String, desc: 'The user\'s username'
      requires :auth_token, type: String, desc: 'The user\'s temporary auth token'
    end
    post '/authentication/login' do
      user = User.find_by(username: params[:username])

      # Ensure user allows logging in via a temporary token
      is_invalid_login = user.nil? || user.auth_token.nil? || user.auth_token_expiry.nil?
      error!({ error: 'Invalid email or token'}, 401) if is_invalid_login

      is_invalid_token = user.auth_token != params[:auth_token] || user.auth_token_expiry < Time.zone.now
      error!({ error: 'Invalid email or token'}, 401) if is_invalid_token

      User.invalidate_token(user)

      token = JwtHelpers.jwt_encode(user_id: user.id)
      response = { token: token }
      present response, with: Grape::Presenters::Presenter
    end
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
      does_user_details_match_payload = @user&.authenticate(params[:password])

      if does_user_details_match_payload
        token = JwtHelpers.jwt_encode(user_id: @user.id)
        response = { token: token }
        present response, with: Grape::Presenters::Presenter
      else
        error!({ error: 'Invalid email or password'}, 401)
      end
    end
  end
end
