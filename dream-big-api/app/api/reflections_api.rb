require 'grape'

class ReflectionsApi < Grape::API
  desc 'Allow retrieval of a Reflection'
  get '/reflections/:id' do
    # Auth

    reflection = Reflection.find(params[:id])
    present reflection, with: Entities::ReflectionsEntity
  end

  desc 'Allow creation of a Reflection'
  params do
    requires :id, type: Integer, desc: 'ID of reflection'
    requires :section_id, type: Integer, desc: 'section ID'
    requires :goal_id, type: Integer, desc: 'goal ID'
    requires :reflection_text, type: String, desc: 'details of the reflection'
  end
  post '/reflections' do
    reflection_parameters = ActionController::Parameters
      .new(params)
      .permit(
        :id,
        :section_id,
        :goal_id,
        :reflection_text
      )

    # Auth...

    created_reflection = Reflection.create!(reflection_parameters)

    present created_reflection, with: Entities::ReflectionsEntity
  end

  desc 'Allow updating of a Goal'
  params do
    requires :id, type: Integer, desc: 'ID of reflection'
    optional :section_id, type: Integer, desc: 'section ID'
    optional :goal_id, type: Integer, desc: 'goal ID'
    optional :reflection_text, type: String, desc: 'details of the reflection'
  end
  put '/reflections/:id' do
    reflection_parameters = ActionController::Parameters
      .new(params)
      .permit(
        :section_id,
        :goal_id,
        :reflection_text
      )

    # Auth

    update_reflection = Reflection.find(params[:id])
    update_reflection.update!(reflection_parameters)

    present update_reflection, with: Entities::ReflectionsEntity
  end

  desc 'Delete the reflection with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of the reflection'
  end
  delete '/reflections/:id' do
    Reflection.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the reflections'
  get '/reflections' do
    reflections = Reflection.all

    present reflections, with: Entities::ReflectionsEntity
  end
end
