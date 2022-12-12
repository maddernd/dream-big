require 'grape'

class AvatarApi < Grape::API
  desc 'Allow retrieval of a users Avatar'
  get '/avatar/:id' do
    # Auth

    avatar = Avatar.find(params[:id])
    present avatar, with: Entities::AvatarEntity
  end

  desc 'Allow creation of an Avatar'
  params do
    requires :avatar_head_id, type: Integer, desc: 'Avatar Head ID'
    requires :avatar_torsos_id, type: Integer, desc: 'Avatar torso ID'
    requires :avatar_hairs_id, type: Integer, desc: 'Avatar hair ID'
    requires :avatar_accessories_id, type: Integer, desc: 'Avatar accessories ID'
  end
  post '/avatar' do
    avatar_parameters = ActionController::Parameters.new(params)
      .permit(
        :avatar_head_id,
        :avatar_torsos_id,
        :avatar_hairs_id,
        :avatar_accessories_id
      )

    # Auth...

    created_avatar = Avatar.create!(avatar_parameters)

    present created_avatar, with: Entities::AvatarEntity
  end

  desc 'Allow updating of a Avatar'
  params do
    optional :avatar_head_id, type: Integer, desc: 'Avatar Head ID'
    optional :avatar_torsos_id, type: Integer, desc: 'Avatar torso ID'
    optional :avatar_hairs_id, type: Integer, desc: 'Avatar hair ID'
    optional :avatar_accessories_id, type: Integer, desc: 'Avatar accessories ID'
  end
  put '/avatar/:id' do
    avatar_parameters = ActionController::Parameters.new(params)
      .permit(
        :avatar_head_id,
        :avatar_torsos_id,
        :avatar_hairs_id,
        :avatar_accessories_id
      )

    # Auth

    update_avatar = Avatar.find(params[:id])
    update_avatar.update!(avatar_parameters)

    present update_avatar, with: Entities::AvatarEntity
  end

  desc 'Delete the Avatar with the indicated id'
  params do
    requires :id, type: Integer, desc: 'The id of the Avatar to delete'
  end
  delete '/avatar/:id' do
    Avatar.find(params[:id]).destroy!
    return true
  end

  desc 'Get all the avatars'
  get '/avatar' do
    avatars = Avatar.all

    present avatars, with: Entities::AvatarEntity
  end
end
