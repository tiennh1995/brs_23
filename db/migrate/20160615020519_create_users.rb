class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.boolean :is_admin, default: false
      t.string :remember_digest

      t.timestamps null: false
    end
    add_index :users, [:fullname, :email], unique: true
  end
end
