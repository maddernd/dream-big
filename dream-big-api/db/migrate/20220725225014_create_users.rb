class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.bigint :role_id
      t.string :auth_token
      t.datetime :auth_token_expiry
      t.timestamps
    end
    add_foreign_key :users, :roles, ondelete: :cascade, column: :role_id
  end
end
