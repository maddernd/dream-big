require "grape"
require "bcrypt"

class UsersApi < Grape::API

  desc "Retrieve a user by ID"
  params do
    requires :id, type: Integer, desc: "The ID of the user to retrieve"
  end
  get "/users/:id" do
    user = User.find_by(id: params[:id])
    if user.nil?
      error!("User not found", 404)
    else
      present user, with: Entities::UsersEntity
    end
  end

  desc "Create a new user"
  params do
    requires :username, type: String, desc: "The username used for login"
    requires :name, type: String, desc: 'The user\'s name'
    requires :email, type: String, desc: "The email used for login"
    requires :password, type: String, desc: "The password for the user"
    requires :role_id, type: Integer, desc: "Role for the user"
  end
  post "/users" do
    user_params = declared(params, include_missing: false)
    user_params[:password] = BCrypt::Password.create(user_params[:password])
    user = User.create(user_params)

    if user.valid?
      present user, with: Entities::UsersEntity
    else
      error!(user.errors.full_messages, 400)
    end
  end

  desc "Update an existing user"
  params do
    optional :username, type: String, desc: "The username used for login"
    optional :name, type: String, desc: 'The user\'s name'
    optional :email, type: String, desc: "The email used for login"
    optional :password, type: String, desc: "The password for the user"
    optional :role_id, type: Integer, desc: "Role for the user"
  end
  put "/users/:id" do
    user = User.find_by(id: params[:id])
    if user.nil?
      error!("User not found", 404)
    else
      user_params = ActionController::Parameters.new(params).permit(:username, :name, :email, :password, :role_id)
      user.update(user_params)
      present user, with: Entities::UsersEntity
    end
  end

  desc "Delete the user with the indicated id"
  params do
    requires :id, type: Integer, desc: "The id of the user to delete"
  end
  delete "/users/:id" do
    user = User.find_by(id: params[:id])
    if user.nil?
      error!("User not found", 404)
    else
      user.destroy
      status 204
    end
  end

  desc "Get all the users"
  params do
    optional :filter, type: String, desc: "Limit response to those users starting with this filter"
  end
  get "/users" do
    filter = params[:filter]
    if filter.nil?
      users = User.all
    else
      users = User.where("name LIKE ?", "#{filter}%")
    end
    present users, with: Entities::UsersEntity
  end
end
