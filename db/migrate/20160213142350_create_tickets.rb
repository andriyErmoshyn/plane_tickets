class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user, index: true, foreign_key: true
      t.references :route, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
