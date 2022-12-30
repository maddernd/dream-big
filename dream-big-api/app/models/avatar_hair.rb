class AvatarHair < ApplicationRecord
	has_one :avatar, foreign_key: :avatar_hair_id
  end
  