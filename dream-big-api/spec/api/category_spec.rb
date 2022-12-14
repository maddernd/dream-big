require 'spec_helper'
require 'rails_helper'


class CategorySpec

  describe CategoryApi do
    include Rack::Test::Methods

    def app 
      CategoryApi
    end

    #GET Test
    describe 'GET /api/category' do
      it 'gets categories' do
        get '/api/category'
        expect(last_response.status).to eq 200
        end
      end

    
    #POST test
    describe 'POST /api/category' do
      it 'creates a category' do
        
        post '/api/category', 
        {"name": "category 0001", 
        "description": "description of category"},
        'Accept' => 'application/json', 
        'Content-Type' => 'application/json'
        
        expect(last_response.status).to eq 201
      end
    end
   end
 end


