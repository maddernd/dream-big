class CreateReflections < ActiveRecord::Migration[7.0]
  def change
    create_table :reflections do |t|
      t.string :reflection_text
      t.bigint :section_id, null: false
      t.bigint :goal_id, null: false
      t.timestamps
    end
  end
end
