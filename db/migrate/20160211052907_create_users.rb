class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,                null: false
      t.string :first_name,        null: false, limit: 30
      t.string :last_name,        null: false, limit: 30
      t.string :phone_number, null: false
      t.string :password_digest

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
