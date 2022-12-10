require 'grape'

class CategoryApi < Grape::API
  desc 'Allow retrieval of a single category'
  get '/category/:id' do
    # Auth

    result = Category.find(params[:id])
    present result, with: Entities::CategoryEntity
  end

  params do
    requires :id, type: Integer, desc: 'Category ID'
    requires :name, type: String, desc: 'Category name'
    requires :description, type: String, desc: 'The description of the category'
  end
  post '/category' do
    category_parameters = ActionController::Parameters.new(params)
      .permit(
        :name,
        :description
      )

    # Auth...

    result = Category.create!(category_parameters)

    present result, with: Entities::CategoryEntity
  end

  desc 'Allow updating of a categories'
  params do
    optional :name, type: String, desc: 'The category name'
    optional :description, type: String, desc: 'The description of the category'
  end
  put '/category/:id' do
    category_parameters = ActionController::Parameters.new(params)
      .permit(
        :name,
        :description
      )

    # Auth

    result = Category.find(params[:id])
    result.update! category_parameters

    present result, with: Entities::CategoryEntity
  end

  desc 'Delete the category with the indicated id'
  params do
    requires :id, type: Integer, desc: 'The id of the category to delete'
  end
  delete '/category/:id' do
    Category.find(params[:id]).destroy!
    return true
  end

  get '/category' do
    result = Category.all

    present result, with: Entities::CategoryEntity
  end
end