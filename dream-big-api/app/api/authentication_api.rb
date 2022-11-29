require 'grape'

class AuthenticationApi < Grape::API
  desc 'Authentication method configuration'
  get '/authentication/method' do
    response = {
      method: DreamBig_Api::Application.config.auth_method
    }

    present response, with: Grape::Presenters::Presenter
  end
end