module  Admin
  class TicketsController < AdminController
    load_resource

    # def index
    #   @tickets = Ticket.all
    # end

    def update
      # @ticket = Ticket.find(params[:id])
      if params[:status] == "approved_#{@ticket.id}"
        @ticket.update_attribute(:status, 0)
        UserMailer.approve_ticket(@ticket.user).deliver_now
        redirect_to admin_tickets_path
      elsif params[:status] == "rejected_#{@ticket.id}"
        @ticket.update_attribute(:status, 1)
        UserMailer.reject_ticket(@ticket.user).deliver_now
        redirect_to admin_tickets_path
      else
        redirect_to admin_tickets_path
      end
    end

  end
end
