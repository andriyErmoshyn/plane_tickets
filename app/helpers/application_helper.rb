module ApplicationHelper
  def formatted_duration (arrive, depart)
    total_seconds = arrive - depart
    hours, sec_left = total_seconds.divmod(3600)
    minutes = (sec_left/60).round
    hrs = pluralize("#{ hours }", 'hour')
    mins = pluralize("#{minutes}", 'min')
    "#{hrs} #{mins}"
  end
end
