require 'grape'

class AvatarAccessoriesApi < Grape::API
  desc 'Allow retrieval of a users avatar-accessories'
  get '/avatar-accessories/:id' do
    # Auth

    accessory = AvatarAccessory.find(params[:id])
    present accessory, with: Entities::AvatarAccessoriesEntity
  end

  desc 'Allow creation of an Avatar Accessory'
  params do
    requires :imgpath, type: String, desc: 'Link to Accesory image for avatar-accessories'
  end
  post '/avatar-accessories' do
    avatar_accessories_parameters = ActionController::Parameters.new(params)
      .permit(
        :imgpath
      )

    # Auth...

    createdAccessory = AvatarAccessory.create!(avatar_accessories_parameters)

    present createdAccessory, with: Entities::AvatarAccessoriesEntity
  end

  desc 'Allow updating of a Avatar accessories'
  params do
    optional :imgpath, type: String, desc: 'Link to Accesory image for avatar-accessories'
  end

  put '/avatar-accessories/:id' do
    avatar_accessories_parameters = ActionController::Parameters.new(params)
      .permit(
        :imgpath
      )

    # Auth

    updateAccessory = AvatarAccessory.find(params[:id])
    updateAccessory.update!(avatar_accessories_parameters)

    present updateAccessory, with: Entities::AvatarAccessoriesEntity
  end

  desc 'Delete the Avatar with the indicated id'
  params do
    requires :id, type: Integer, desc: 'The id of the avatar-accessories to delete'
  end
  delete '/avatar-accessories/:id' do
    AvatarAccessory.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the avatar accessories'
  get '/avatar-accessories' do
    avatarAccessories = AvatarAccessory.all

    present avatarAccessories, with: Entities::AvatarAccessoriesEntity
  end
end
