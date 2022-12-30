class CreateCategoryQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :category_questions do |t|
      t.string :question
      t.bigint :category_id, null: false
      t.timestamps
    end
  end
end
