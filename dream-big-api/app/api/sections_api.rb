require 'grape'

class SectionsApi < Grape::API
  desc 'Allow retrieval of a Section'
  get '/sections/:id' do
    # Auth

    section = Section.find(params[:id])
    present section, with: Entities::SectionsEntity
  end

  desc 'Allow creation of a Section'
  params do
    requires :id, type: Integer, desc: 'ID of section'
    requires :planet_id, type: Integer, desc: 'planet ID'
    requires :category_id, type: Integer, desc: 'category ID'
  end
  post '/sections' do
    section_parameters = ActionController::Parameters
                          .new(params)
                          .permit(
                            :id,
                            :planet_id,
                            :category_id
                          )

    # Auth...

    created_section = Section.create!(section_parameters)

    present created_section, with: Entities::SectionsEntity
  end

  desc 'Allow updating of a Section'
  params do
    requires :id, type: Integer, desc: 'ID of section'
    optional :planet_id, type: Integer, desc: 'planet ID'
    optional :category_id, type: Integer, desc: 'category ID'
  end
  put '/sections/:id' do
    section_parameters = ActionController::Parameters
                          .new(params)
                          .permit(
                            :planet_id,
                            :category_id
                          )

    # Auth

    update_section = Section.find(params[:id])
    update_section.update!(section_parameters)

    present update_section, with: Entities::SectionsEntity
  end

  desc 'Delete the Section with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of the section'
  end
  delete '/sections/:id' do
    Section.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the selections'
  get '/sections' do
    sections = Section.all

    present sections, with: Entities::SectionsEntity
  end
end
