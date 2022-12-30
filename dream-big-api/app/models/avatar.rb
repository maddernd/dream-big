class Avatar < ApplicationRecord
  belongs_to :student
  belongs_to :avatar_head, class_name: 'AvatarHead', foreign_key: :avatar_head_id
  belongs_to :avatar_hair, class_name: 'AvatarHair', foreign_key: :avatar_hair_id
  belongs_to :avatar_torso, class_name: 'AvatarTorso', foreign_key: :avatar_torso_id
  belongs_to :avatar_accessory, class_name: 'AvatarAccessory', foreign_key: :avatar_accessory_id
end
