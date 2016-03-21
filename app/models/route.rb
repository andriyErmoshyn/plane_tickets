class Route < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  has_many :tickets, dependent: :destroy
  has_many :users, through: :tickets

  validates :start_point, :end_point, :depart, :arrive, :price, presence: true
  validates :route_number, presence: true, uniqueness: true

  scope :start_point, -> (start_point) { where start_point: start_point }
  scope :end_point, -> (end_point) { where end_point: end_point }
  scope :depart, -> (depart) { where("to_char(depart, 'YYYY-MM-DD') LIKE ?",
                                                      "#{depart}%") }
  scope :city, -> (city) { where("start_point LIKE ? OR end_point like ?",
                                              "#{city}%", "#{city}%") }

  def duration
    arrive - depart
  end

  def formatted_duration
    hours, sec_left = duration.divmod(3600)
    minutes = (sec_left/60).round
    hrs = pluralize(hours, 'hour')
    mins = pluralize( minutes, 'min')
    "#{hrs} #{mins}"
  end

  def free_seats
    seats - tickets.count
  end

  def sold_out?
    free_seats.zero?
  end

end
