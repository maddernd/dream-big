require 'spec_helper'
require 'rails_helper'


class UserSpec

  describe UsersApi do
    include Rack::Test::Methods

    def app 
      UsersApi
    end


    #GET Test
    describe 'GET /api/users' do
      it 'gets all users' do
        get '/api/users'
        expect(last_response.status).to eq 200
        end
      end

    #POST Test
    describe 'POST /api/users' do
      it 'creates a user' do
        
        post '/api/users', 
        {"username": "hsmith", 
        "name": "Dean Smith", 
        "email": "asdfmith@angryfish.com", 
        "password": "pwi88asa3eeif3#"},
        'Accept' => 'application/json', 
        'Content-Type' => 'application/json'
        
        expect(last_response.status).to eq 201
      end
    end
   end
 end


