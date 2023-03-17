module Entities
  class UsersEntity < Grape::Entity
    expose :id
    expose :username
    expose :name
    expose :email
    expose :role_id
  end
end
