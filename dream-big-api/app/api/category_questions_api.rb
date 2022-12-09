require 'grape'

class CategoryQuestionsApi < Grape::API
  desc 'Allow retrieval of an Answer in the Assessment'
  get '/category-questions/:id' do
    # Auth

    result = CategoryQuestion.find(params[:id])
    present result, with: Entities::CategoryQuestionsEntity
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

    result = CategoryQuestion.create!(category_questions_parameters)

    present result, with: Entities::CategoryQuestionsEntity
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

    result = CategoryQuestion.find(params[:id])
    result.update!(category_questions_parameters)

    present result, with: Entities::CategoryQuestionsEntity
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
    result = CategoryQuestion.all

    present result, with: Entities::CategoryQuestionsEntity
  end
end