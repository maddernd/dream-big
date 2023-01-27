require "spec_helper"
require "rails_helper"

RSpec.describe UsersApi do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  params = { username: "lsmith",
             name: "Leanne Smith",
             email: "lsmith@angryfish.com",
             password: "pwi88asa3eeif3#" }

  new_params = { username: "tjones",
                 name: "Toby Jones",
                 email: "tjones@globalnet.com",
                 password: "pwi88asa3eeif3#" }

  let!(:user) { User.create!(params) }

  describe "POST /api/users" do
    it "creates a user" do
      post "/api/users", params

      response = JSON.parse(last_response.body)
      expect(last_response.status).to eq 201
      expect(response.include?(params))
    end
  end

  describe "GET /api/users" do
    it "retrieves a user" do
      get "/api/users/#{user.id}"

      response = JSON.parse(last_response.body)
      expect(last_response.status).to eq 200
      expect(response.include?(params))
    end
  end

  describe "PUT /api/users/:id" do
    it "modifies a user" do
      put "/api/users/#{user.id}", new_params
      expect(last_response.status).to eq 200
      response = JSON.parse(last_response.body)
      expect(response.include?(new_params))
    end
  end

  describe "DELETE /api/users/:id" do
    it "deletes a user" do
      delete "/api/users/#{user.id}"
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq "User deleted"
    end
  end
end
