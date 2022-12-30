class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.bigint :journey_id, null: false
      t.bigint :category_id, null: false
      t.timestamps
    end
  end
end
