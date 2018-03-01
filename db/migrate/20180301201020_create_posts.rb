class CreatePosts < ActiveRecord::Migration[4.2]
  create_table :posts do |t|
    t.string :title
    t.string :category
    t.date :date
    t.text :description
    t.integer :user_id
  end
end
