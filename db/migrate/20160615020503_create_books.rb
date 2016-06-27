class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.date :publish_date
      t.string :author
      t.integer :pages
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :books, [:title, :publish_date, :author, :category_id], name: "index_books", unique: true
  end
end
