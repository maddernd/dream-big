require 'grape'

class AnswersApi < Grape::API
  desc 'Allow retrieval of an Answer in the Assessment'
  get '/answers/:id' do
    # Auth

    answer = Answer.find(params[:id])
    present answer, with: Entities::AnswersEntity
  end

  desc 'Allow creation of an Answers'
  params do
    requires :id, type: Integer, desc: 'ID of Answer'
    requires :category_question_id, type: Integer, desc: 'question ID'
    requires :assessment_id, type: Integer, desc: 'assessment ID'
    requires :answer, type: String, desc: 'answer text'
  end
  post '/answers' do
    answers_parameters = ActionController::Parameters.new(params)
      .permit(
        :id,
        :category_question_id,
        :assessment_id,
        :answer
      )

    # Auth...

    created_answer = Answer.create!(answers_parameters)

    present created_answer, with: Entities::AnswersEntity
  end

  desc 'Allow updating of a Answers'
  params do
    requires :id, type: Integer, desc: 'ID of Answer'
    optional :category_question_id, type: Integer, desc: 'question ID'
    optional :assessment_id, type: Integer, desc: 'assessment ID'
    optional :answer, type: String, desc: 'answer text'
  end
  put '/answers/:id' do
    answers_parameters = ActionController::Parameters.new(params)
      .permit(
        :category_question_id,
        :assessment_id,
        :answer
      )

    # Auth

    update_answer = Answer.find(params[:id])
    update_answer.update! answers_parameters

    present update_answer, with: Entities::AnswersEntity
  end

  desc 'Delete the Answers with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of Answer'
  end
  delete '/answers/:id' do
    Answer.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the answers'
  get '/answers' do
    answers = Answer.all

    present answers, with: Entities::AnswersEntity
  end
end
