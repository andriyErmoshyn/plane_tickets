class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :start_point, null: false
      t.string :end_point,   null: false
      t.datetime :depart,   null: false
      t.datetime :arrive,    null: false
      t.decimal :price,       null: false, precision: 6, scale: 2

      t.timestamps null: false
    end
  end
end
