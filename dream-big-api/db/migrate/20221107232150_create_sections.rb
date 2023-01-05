class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.bigint :planet_id, null: false
      t.bigint :category_id, null: false
      t.timestamps
    end
  end
end
