module AuthenticationHelpers
  module_function

  # TODO: Add further checks here
  def authenticate_request
    header = headers["Authorization"]
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end

  #
  # Returns true if using SAML2.0 auth strategy
  #
  def saml_auth?
    DreamBig_Api::Application.config.auth_method == :saml
  end

  #
  # Returns true if using AAF devise auth strategy
  #
  def aaf_auth?
    DreamBig_Api::Application.config.auth_method == :aaf
  end

  #
  # Returns true if using database devise auth strategy
  #
  def db_auth?
    DreamBig_Api::Application.config.auth_method == :database
  end
end
