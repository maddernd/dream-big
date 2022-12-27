require 'spec_helper'
require 'rails_helper'


class AvatarAccessories

    describe AvatarAccessoriesApi do
        include Rack::Test::Methods

        def app 
        AvatarAccessoriesApi
        end

        params = {"imgpath": "//asfe/asdf/asdjf"}
                    
        new_params = {"imgpath": "//asfe/asdf/asdjf"}
                    
        let(:avatar_accessory) {AvatarAccessory.create!(params)}


        describe 'POST /api/avatar-accessories' do
            it 'creates an avatar accessory' do
                post '/api/avatar-accessories', params
            
                response = JSON.parse(last_response.body)
                expect(last_response.status).to eq 201
                expect(response.include?(params))
            end
        end
        
        describe 'GET /api/avatar-accessories' do
            it 'retrieves an avatar accessory' do
                get '/api/avatar-accessories/'+ avatar_accessory[:id].to_s

                response = JSON.parse(last_response.body)
                expect(last_response.status).to eq 200
                expect(response.include?(params))
            end
        end
        
        describe 'PUT /api/avatar-accessories/:id' do
            it 'modifies an avatar accessory' do
                put '/api/avatar-accessories/' + avatar_accessory[:id].to_s, new_params
                expect(last_response.status).to eq 200
                response = JSON.parse(last_response.body)
                expect(response.include?(new_params))
            end
        end

        describe 'DELETE /api/avatar-accessories/:id' do
            it 'deletes an avatar accessory' do
                delete '/api/avatar-accessories/' + avatar_accessory[:id].to_s
                expect(last_response.status).to eq 200
                expect(last_response.body).to eq "true"
            end
        end
    end
end


