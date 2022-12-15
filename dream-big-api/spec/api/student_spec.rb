require 'spec_helper'
require 'rails_helper'


class StudentSpec

  describe StudentApi do
    include Rack::Test::Methods

    def app 
     StudentApi
    end

    #GET test
    describe 'GET /api/student' do
      it 'gets students' do
        get '/api/student'
        expect(last_response.status).to eq 200
        end
      end

    
    #POST test
    describe 'POST /api/student' do
      it 'creates a student' do
        
        post '/api/student', 
        {"firstName": "myname", 
        "lastName": "mylastname",
        "phone": "0123456789",
        "user_id":  "123"},
        'Accept' => 'application/json', 
        'Content-Type' => 'application/json'
        
        expect(last_response.status).to eq 201
      end
    end
   end
 end