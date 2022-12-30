class AvatarHead < ApplicationRecord
	has_one :avatar, foreign_key: :avatar_head_id
  end
  