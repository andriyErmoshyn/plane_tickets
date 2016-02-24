module Admin
  class RoutesController < AdminController
    load_resource

    def create      
      if @route.save
        flash[:success] = "Successfully created..."
        redirect_to admin_routes_path
      else
        flash.now[:danger] = "Something went wrong..."
        render 'new'
      end
    end

    def update      
      if @route.update_attributes(route_params)
        flash[:success] = "Route updated"
        redirect_to admin_routes_path
      else
        flash.now[:danger] = "Something went wrong..."
        render 'edit'
      end
    end

    private
      def route_params
        params.require(:route).permit(:route_number, 
          :start_point, :end_point, :depart, :arrive, :price, :seats)
      end

  end
end
