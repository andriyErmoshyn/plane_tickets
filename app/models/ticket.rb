class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  enum status: [:approved, :rejected]
end
