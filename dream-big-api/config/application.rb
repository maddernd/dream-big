require File.expand_path('../boot', __FILE__)
require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DreamBig_Api
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    Dotenv::Railtie.load

    # ==> Authentication Method
    # Authentication method default is database, but possible settings
    # are: database, aaf, or saml. It can be overridden using the DF_AUTH_METHOD
    # environment variable.
    config.auth_method = (ENV['DF_AUTH_METHOD'] || :database).to_sym

    # AAF authentication
    if config.auth_method == :aaf
      config.aaf = HashWithIndifferentAccess.new
      # URL of the issuer (i.e., https://rapid.[test.]aaf.edu.au)
      config.aaf[:issuer_url] = ENV['DF_AAF_ISSUER_URL'] || 'https://rapid.test.aaf.edu.au'
      # URL of the registered application (e.g., https://dreambig.unifoo.edu.au)
      config.aaf[:audience_url] = ENV['DF_AAF_AUDIENCE_URL']
      # The secure URL within your application that AAF Rapid Connect should
      # POST responses to (e.g., https://dreambig.unifoo.edu.au/auth/jwt)
      config.aaf[:callback_url] = ENV['DF_AAF_CALLBACK_URL']
      # URL of the unique url provided by rapid connect used for redirect
      # (e.g., https://rapid.aaf.edu.au/jwt/authnrequest/auresearch/XXXXXXX)
      config.aaf[:redirect_url] = ENV['DF_AAF_UNIQUE_URL']
    end


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => :any
      end
    end
  end
end