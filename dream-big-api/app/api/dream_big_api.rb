require "grape"
require "grape-swagger"

class DreamBigApi < Grape::API
  prefix "api"
  format :json

  before do
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "POST, PUT, DELETE, GET, OPTIONS"
    headers["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  end

  rescue_from :all do |e|
    case e
    when ActiveRecord::RecordInvalid, Grape::Exceptions::ValidationErrors
      message = e.message
      status = 400
    when ActiveRecord::InvalidForeignKey
      message = "This operation has been rejected as it would break data integrity. Ensure that related values are deleted or updated before trying again."
      status = 400
    when Grape::Exceptions::MethodNotAllowed
      message = e.message
      status = 405
    when ActiveRecord::RecordNotDestroyed
      message = e.message
      status = 400
    when ActiveRecord::RecordNotFound
      message = "Unable to find requested #{e.message[/(Couldn't find )(.*)( with)/, 2]}"
      status = 404
    else
      # logger.error "Unhandled exception: #{e.class}"
      # logger.error e.inspect
      # logger.error e.backtrace.join("\n")

      puts "FAILING!"
      puts e.inspect
      puts e.backtrace.join("\n")

      message = "Sorry... something went wrong with your request."
      message = e.inspect
      status = 500
    end
    Rack::Response.new({ error: message }.to_json, status, { "Content-type" => "text/error" })
  end

  #mount DreamBigApi
  mount AuthenticationApi
  mount CategoryApi
  mount UsersApi
  mount StudentApi
  mount AvatarApi
  mount AvatarHairsApi
  mount AvatarHeadsApi
  mount AvatarAccessoriesApi
  mount AvatarTorsosApi
  mount AnswersApi
  mount AssessmentsApi
  mount CategoryQuestionsApi
  mount JourneysApi
  mount PlanetsApi
  mount SectionsApi
  mount GoalsApi
  mount ReflectionsApi
  mount PlansApi

  add_swagger_documentation(
    base_path: nil,
    api_version: "v1",
    hide_documentation_path: true,
    info: {
      title: "Dream-big-api API Documentaion",
      description: "Dreambig-api is an entity service and web socket proof of concept.",
      license: "AGPL v3.0",
      license_url: "https://github.com/doubtfire-lms/dream-big/blob/main/LICENSE",
    },
    mount_path: "swagger_doc"
  )
end
