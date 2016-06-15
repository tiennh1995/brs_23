class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :read
      t.boolean :is_favorite, default: false
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :marks, [:read, :is_favorite], name: "index_mark", unique: true
  end
end
