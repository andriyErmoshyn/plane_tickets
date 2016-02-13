class Route < ActiveRecord::Base

  validates :start_point, :end_point, :depart, :arrive, :price, presence: true
  
end
