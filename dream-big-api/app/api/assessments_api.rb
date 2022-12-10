require 'grape'

class AssessmentsApi < Grape::API
  desc 'Allow retrieval of an Answer in the Assessment'
  get '/assessments/:id' do
    # Auth

    assessment = Assessment.find(params[:id])
    present assessment, with: Entities::AssessmentsEntity
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

    createdAssessment = Assessment.create!(assessments_parameters)

    present createdAssessment, with: Entities::AssessmentsEntity
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
        :id,
        :journey_id,
        :category_id
      )

    # Auth

    updateAssessment = Assessment.find(params[:id])
    updateAssessment.update! assessments_parameters

    present updateAssessment, with: Entities::AssessmentsEntity
  end

  desc 'Delete the Assessments with the indicated id'
  params do
    requires :id, type: Integer, desc: 'Assessment ID'
  end
  delete '/assessments/:id' do
    Assessment.find(params[:id]).destroy!
    return true
  end

  desc 'Get all the assessments'
  get '/assessments' do
    assessments = Assessment.all

    present assessments, with: Entities::AssessmentsEntity
  end
end
