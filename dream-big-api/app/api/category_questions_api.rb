require 'grape'

class CategoryQuestionsApi < Grape::API
  desc 'Allow retrieval of an Answer in the Assessment'
  get '/category-questions/:id' do
    # Auth

    question = CategoryQuestion.find(params[:id])
    present question, with: Entities::CategoryQuestionsEntity
  end

  desc 'Allow creation of a Category Question'
  params do
    requires :id, type: Integer, desc: 'ID of the Category Question'
    requires :question, type: String, desc: 'question text'
    requires :category_id, type: Integer, desc: 'category ID'
  end
  post '/category-questions' do
    category_questions_parameters = ActionController::Parameters
        .new(params)
        .permit(
          :id,
          :question,
          :category_id
        )

    # Auth...

    created_category_question = CategoryQuestion.create!(category_questions_parameters)

    present created_category_question, with: Entities::CategoryQuestionsEntity
  end

  desc 'Allow updating a Category Question'
  params do
    requires :id, type: Integer, desc: 'ID of the Category Question'
    optional :question, type: String, desc: 'question text'
    optional :category_id, type: Integer, desc: 'category ID'
  end
  put '/category-questions/:id' do
    category_questions_parameters = ActionController::Parameters
        .new(params)
        .permit(
          :question,
          :category_id,
        )

    # Auth

    update_category_question = CategoryQuestion.find(params[:id])
    update_category_question.update!(category_questions_parameters)

    present update_category_question, with: Entities::CategoryQuestionsEntity
  end

  desc 'Delete the Category Question with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of the Category Question'
  end
  delete '/category-questions/:id' do
    CategoryQuestion.find(params[:id]).destroy!
    true
  end

  desc 'Get all the catagory questions'
  get '/category-questions' do
    catagory_questions = CategoryQuestion.all

    present catagory_questions, with: Entities::CategoryQuestionsEntity
  end
end