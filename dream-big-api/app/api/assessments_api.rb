require 'grape'

class AssessmentsApi < Grape::API
  desc 'Allow retrieval of an Answer in the Assessment'
  get '/assessments/:id' do
    # Auth

    result = Assessment.find(params[:id])
    present result, with: Entities::AssessmentsEntity
  end

  desc 'Allow creation of an Assessments'
  params do
    requires :id, type: Integer, desc: 'Assessment ID'
    requires :journey_id, type: Integer, desc: 'Journey ID'
    requires :category_id, type: Integer, desc: 'category ID'
  end
  post '/assessments' do
    assessments_parameters = ActionController::Parameters.new(params)
      .permit(
        :id,
        :journey_id,
        :category_id
      )

    # Auth...

    result = Assessment.create!(assessments_parameters)

    present result, with: Entities::AssessmentsEntity
  end

  desc 'Allow updating of a Assessments'
  params do
    requires :id , type: Integer, desc: 'Assessment ID'
    optional :journey_id, type: Integer, desc: 'Journey ID'
    optional :category_id, type: Integer, desc: 'category ID'

  end
  put '/assessments/:id' do
    assessments_parameters = ActionController::Parameters.new(params)
      .permit(
        :journey_id,
        :category_id
      )

    # Auth

    result = Assessment.find(params[:id])
    result.update! assessments_parameters

    present result, with: Entities::AssessmentsEntity
  end

  desc 'Delete the Assessments with the indicated id'
  params do
    requires :id, type: Integer, desc: 'Assessment ID'
  end
  delete '/assessments/:id' do
    Assessment.find(params[:id]).destroy!
    return true
  end

  get '/assessments' do
    result = Assessment.all

    present result, with: Entities::AssessmentsEntity
  end
end
