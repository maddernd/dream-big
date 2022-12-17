require 'spec_helper'
require 'rails_helper'


class CategorySpec

    describe CategoryApi do
        include Rack::Test::Methods

        def app 
        CategoryApi
        end

        params = { 'name' => 'category 01', 
        'description' => 'description of category'}
                    
        new_params = { 'name' => 'category_02', 
        'description' => 'a new category'}
                    
        let(:category) {Category.create!(params)}


        describe 'POST /api/category' do
            it 'creates a category' do
                post '/api/category', params
            
                response = JSON.parse(last_response.body)
                expect(last_response.status).to eq 201
                expect(response.include?(params))
            end
        end
        
        describe 'GET /api/category' do
            it 'retrieves a category' do
                get '/api/category/'+ category[:id].to_s

                response = JSON.parse(last_response.body)
                expect(last_response.status).to eq 200
                expect(response.include?(params))
            end
        end
        
        describe 'PUT /api/category/:id' do
            it 'modifies a category' do
                put '/api/category/' + category[:id].to_s, new_params
                expect(last_response.status).to eq 200
                response = JSON.parse(last_response.body)
                expect(response.include?(new_params))
            end
        end

        describe 'DELETE /api/category/:id' do
            it 'deletes a category' do
                delete '/api/category/' + category[:id].to_s
                expect(last_response.status).to eq 200
                expect(last_response.body).to eq "true"
            end
        end
    end
end





        
        
    
            



