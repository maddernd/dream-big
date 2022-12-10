require 'grape'

class AvatarHairsApi < Grape::API
  desc 'Allow retrieval of a users avatar-hairs'
  get '/avatar-hairs/:id' do
    # Auth

    hair = AvatarHair.find(params[:id])
    present hair, with: Entities::AvatarHairsEntity
  end

  desc 'Allow creation of an Avatar Hairs'
  params do
    requires :imgpath, type: String, desc: 'Link to Accesory image for avatar-Hairs'
  end
  post '/avatar-hairs' do
    avatar_hairs_parameters = ActionController::Parameters.new(params)
      .permit(
        :imgpath
      )

    # Auth...

    createdHair = AvatarHair.create!(avatar_hairs_parameters)

    present createdHair, with: Entities::AvatarHairsEntity
  end

  desc 'Allow updating of a Avatar Hairs'
  params do
    optional :imgpath, type: String, desc: 'Link to Accesory image for avatar-Hairs'
  end

  put '/avatar-hairs/:id' do
    avatar_hairs_parameters = ActionController::Parameters.new(params)
      .permit(
        :imgpath
      )

    # Auth

    updateHair = AvatarHair.find(params[:id])
    updateHair.update!(avatar_hairs_parameters)

    present updateHair, with: Entities::AvatarHairsEntity
  end

  desc 'Delete the Avatar Hairs with the indicated id'
  params do
    requires :id, type: Integer, desc: 'The id of the avatar-Hairs to delete'
  end
  delete '/avatar-hairs/:id' do
    AvatarHair.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the avatar hairs'
  get '/avatar-hairs' do
    avatarHairs = AvatarHair.all

    present avatarHairs, with: Entities::AvatarHairsEntity
  end
end
