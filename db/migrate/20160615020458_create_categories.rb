class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps null: false
    end
    add_index :categories, :name, name: "index_category_on_name", unique: true
  end
end
