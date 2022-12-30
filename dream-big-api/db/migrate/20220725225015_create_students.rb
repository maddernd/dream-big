class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :firstName
      t.string :lastName
      t.integer :phone
      t.string :address
      t.string :student_type
      t.bigint :user_id, null: false
    end
  end
end