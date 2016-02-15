class TicketsController < ApplicationController
  
  def create
    @route = Route.find(params[:route_id])
    @ticket = current_user.tickets.create(route_id: @route.id)
    redirect_to current_user
  end



end
