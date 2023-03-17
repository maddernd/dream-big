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
end
