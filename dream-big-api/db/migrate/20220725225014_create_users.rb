class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest
      t.bigint :role_id, null: false
      t.timestamps
    end
  end
end
