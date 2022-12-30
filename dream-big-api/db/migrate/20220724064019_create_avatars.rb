class CreateAvatars < ActiveRecord::Migration[7.0]
  def change
    create_table :avatars do |t|
      t.bigint :avatar_head_id, null: false
      t.bigint :avatar_torso_id, null: false
      t.bigint :avatar_hair_id, null: false
      t.bigint :avatar_accessory_id, null: false
      t.bigint :student_id, null: false
    end
  end
end
