class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  default_scope -> { order(created_at: :desc) }

  enum status: [:approved, :rejected]
end
