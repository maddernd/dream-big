class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :answer
      t.bigint :category_question_id, null: false
      t.bigint :assessment_id, null: false
      t.timestamps
    end
  end
end
