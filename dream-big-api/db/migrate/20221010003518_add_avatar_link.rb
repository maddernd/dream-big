class AddAvatarLink < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :avatars, :avatar_heads, ondelete: :cascade, column: :avatar_head_id
    add_foreign_key :avatars, :avatar_torsos, ondelete: :cascade, column: :avatar_torso_id
    add_foreign_key :avatars, :avatar_hairs, ondelete: :cascade, column: :avatar_hair_id
    add_foreign_key :avatars, :avatar_accessories, ondelete: :cascade, column: :avatar_accessory_id
  end
end
