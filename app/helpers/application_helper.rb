module ApplicationHelper
  def formatted_duration (arrive, depart)
    total_seconds = arrive - depart
    hours, sec_left = total_seconds.divmod(3600)
    minutes = (sec_left/60).round
    hrs = pluralize("#{ hours }", 'hour')
    mins = pluralize("#{minutes}", 'min')
    "#{hrs} #{mins}"
  end

  def already_bought_ticket?(route)
    if current_user.present?
      @user_route_ids = current_user.tickets.pluck(:route_id)
      @user_route_ids.include?(route.id)
    end
  end
end
