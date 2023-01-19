class User < ApplicationRecord
    require "securerandom"
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    
    #Associations
    has_one :student
    belongs_to :role

end
