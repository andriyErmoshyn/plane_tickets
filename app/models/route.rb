class Route < ActiveRecord::Base

  has_many :tickets
  has_many :users, through: :tickets
  
  validates :start_point, :end_point, :depart, :arrive, :price, presence: true
  
end
