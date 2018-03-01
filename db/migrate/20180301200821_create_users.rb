class CreateUsers < ActiveRecord::Migration[4.2]
  create_table :users do |t|
    t.string :username
    t.string :password_digest
  end
end
