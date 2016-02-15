class AddRouteNumberAndFreeSeatsToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :route_number, :string
    add_column :routes, :seats, :integer, default: 5

    add_index :routes, :route_number, unique: true
  end  
end
