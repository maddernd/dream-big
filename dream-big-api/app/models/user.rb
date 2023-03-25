class User < ApplicationRecord
    require "securerandom"
    has_secure_password
    # Make the token more secure and harder to guess.
    has_secure_token :auth_token, length: 24
    
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    
    #Associations
    has_one :student
    has_one :role

    # Make temporary token inaccessible on creation
    after_create do
        self.auth_token = nil
        self.save
    end

    def self.generate_token(user)
        user.regenerate_auth_token
        user.auth_token_expiry = Time.zone.now + 30.second
        user.save
    end

    def self.invalidate_token(user)
        user.auth_token = nil
        user.auth_token_expiry = nil
        user.save
    end

    def self.is_valid_aaf_jwt(jwt)
        return false if jwt.nil?

        audience = jwt["aud"]
        issuer = jwt["iss"]
        token_start_date = jwt["nbf"] # nbf = not before
        token_end_date = jwt["exp"]

        is_aud_ok = audience == DreamBig_Api::Application.config.aaf[:audience_url]
        is_iss_ok = issuer == DreamBig_Api::Application.config.aaf[:issuer_url]

        # The token MUST not be expired where token is using Unix timestamp
        is_start_date_ok = Time.zone.now >= Time.zone.at(token_start_date.to_i)
        is_end_date_ok = Time.zone.now < Time.zone.at(token_end_date.to_i)
        is_time_ok = is_start_date_ok && is_end_date_ok

        return is_aud_ok && is_iss_ok && is_time_ok
    end
end
