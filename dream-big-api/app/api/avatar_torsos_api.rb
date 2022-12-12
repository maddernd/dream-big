require 'grape'

class AvatarTorsosApi < Grape::API
  desc 'Allow retrieval of a users avatar-torsos'
  get '/avatar-torsos/:id' do
    # Auth

    torso = AvatarTorso.find(params[:id])
    present torso, with: Entities::AvatarTorsosEntity
  end

  desc 'Allow creation of an Avatar Torsos'
  params do
    requires :imgpath, type: String, desc: 'Link to Accesory image for avatar-Torsos'
  end
  post '/avatar-torsos' do
    avatar_torsos_parameters = ActionController::Parameters.new(params)
      .permit(
        :imgpath
      )

    # Auth...

    created_avatar_torso = AvatarHair.create!(avatar_torsos_parameters)

    present created_avatar_torso, with: Entities::AvatarTorsosEntity
  end

  desc 'Allow updating of a Avatar Torsos'
  params do
    optional :imgpath, type: String, desc: 'Link to Accesory image for avatar-Torsos'
  end

  put '/avatar-torsos/:id' do
    avatar_torsos_parameters = ActionController::Parameters.new(params)
      .permit(
        :imgpath
      )

    # Auth

    update_avatar_torso = avatar_torsos_parameters.find(params[:id])
    update_avatar_torso.update!(avatar_torsos_parameters)

    present update_avatar_torso, with: Entities::AvatarTorsosEntity
  end

  desc 'Delete the Avatar Torsos with the indicated id'
  params do
    requires :id, type: Integer, desc: 'The id of the avatar-Torsos to delete'
  end
  delete '/avatar-torsos/:id' do
    AvatarTorso.find(params[:id]).destroy!

    return true
  end

  desc 'get all the avatar torsos'
  get '/avatar-torsos' do
    avatar_torsos = AvatarTorso.all

    present avatar_torsos, with: Entities::AvatarTorsosEntity
  end
end
