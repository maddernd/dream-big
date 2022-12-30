class AvatarTorso < ApplicationRecord
	has_one :avatar, foreign_key: :avatar_torso_id
  end
  