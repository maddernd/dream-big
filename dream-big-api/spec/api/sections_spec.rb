require 'spec_helper'
require 'rails_helper'


class SectionSpec

  describe SectionsApi do
    include Rack::Test::Methods

    def app 
      SectionsApi
    end

    #GET test
    describe 'GET /api/sections' do
      it 'gets sections' do
        get '/api/sections'
        expect(last_response.status).to eq 200
        end
      end

    
    #POST test
    describe 'POST /api/sections' do
      it 'creates a section' do
        
        post '/api/sections', 
        {"Id": "1", 
        "planet_id": "2",
        "category_id": "3"},
        'Accept' => 'application/json', 
        'Content-Type' => 'application/json'
        
        expect(last_response.status).to eq 201
      end
    end
   end
 end