require 'grape'

class PlanetsApi < Grape::API
  desc 'Allow retrieval of a Planet'
  get '/planets/:id' do
    # Auth

    planet = Planet.find(params[:id])
    present planet, with: Entities::PlanetsEntity
  end

  desc 'Allow creation of a Planet'
  params do
    requires :id, type: Integer, desc: 'ID of Planet'
    requires :name, type: String, desc: 'name of the planet'
    requires :journey_id, type: Integer, desc: 'journey ID'
  end
  post '/planets' do
    planet_parameters = ActionController::Parameters
       .new(params)
       .permit(
         :id,
         :name,
         :journey_id
       )

    # Auth...

    createdPlanet = Planet.create!(planet_parameters)

    present createdPlanet, with: Entities::PlanetsEntity
  end

  desc 'Allow updating of a Planet'
  params do
    requires :id, type: Integer, desc: 'ID of Planet'
    optional :name, type: String, desc: 'name of the planet'
    optional :journey_id, type: Integer, desc: 'journey ID'
  end
  put '/planets/:id' do
    planet_parameters = ActionController::Parameters
       .new(params)
       .permit(
         :name,
         :journey_id
       )

    # Auth

    updatePlanet = Planet.find(params[:id])
    updatePlanet.update!(planet_parameters)

    present updatePlanet, with: Entities::PlanetsEntity
  end

  desc 'Delete the Planet with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of Planet'
  end
  delete '/planets/:id' do
    Planet.find(params[:id]).destroy!

    return true
  end

  'Get all the planets'
  get '/planets' do
    planets = Planet.all

    present planets, with: Entities::PlanetsEntity
  end
end
