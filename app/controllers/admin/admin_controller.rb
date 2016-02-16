module Admin
  class AdminController < ApplicationController

    before_action :verify_admin

    private
      def verify_admin
        unless current_user.try(:admin?)
          flash[:warning] = "Sorry, you have no rights for this action."
          redirect_to root_url
        end
      end

  end
end
