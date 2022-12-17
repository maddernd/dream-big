require 'spec_helper'
require 'rails_helper'


class UserSpec

    describe UsersApi do
        include Rack::Test::Methods

        def app 
        UsersApi
        end

        params = {  "username": "lsmith", 
                    "name": "Leanne Smith", 
                    "email": "lsmith@angryfish.com", 
                    "password": "pwi88asa3eeif3#"}
    

        new_params = {  "username": "tjones", 
                        "name": "Toby Jones", 
                        "email": "tjones@globalnet.com", 
                        "password": "pwi88asa3eeif3#"}

        let(:user) {User.create!(params)}


        describe 'POST /api/users' do
            it 'creates a user' do
                post '/api/users', params
            
                response = JSON.parse(last_response.body)
                expect(last_response.status).to eq 201
                expect(response.include?(params))
            end
        end
        
        describe 'GET /api/users' do
            it 'retrieves a user' do
                get '/api/users/'+ user[:id].to_s

                response = JSON.parse(last_response.body)
                expect(last_response.status).to eq 200
                expect(response.include?(params))
            end
        end
        
        describe 'PUT /api/users/:id' do
            it 'modifies a user' do
                put '/api/users/' + user[:id].to_s, new_params
                expect(last_response.status).to eq 200
                response = JSON.parse(last_response.body)
                expect(response.include?(new_params))
            end
        end

        describe 'DELETE /api/users/:id' do
            it 'deletes a user' do
                delete '/api/users/' + user[:id].to_s
                expect(last_response.status).to eq 200
                expect(last_response.body).to eq "true"
            end
        end
    end
end





        
        
    
            



