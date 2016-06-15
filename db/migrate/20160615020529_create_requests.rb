class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :book_title
      t.date :book_publish_date
      t.string :book_author
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :requests, [:user_id, :created_at], unique: true
  end
end
