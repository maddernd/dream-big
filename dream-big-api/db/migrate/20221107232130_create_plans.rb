class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.bigint :section_id, null: false
      t.bigint :goal_id, null: false
      t.string :plan_text
      t.timestamps
    end
  end
end
