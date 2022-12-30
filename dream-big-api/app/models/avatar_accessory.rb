class AvatarAccessory < ApplicationRecord
	has_one :avatar, foreign_key: :avatar_accessory_id
  end
  