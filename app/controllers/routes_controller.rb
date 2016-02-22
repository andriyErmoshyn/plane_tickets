class RoutesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    if params[:sort] == 'duration'
      if sort_direction == 'asc'
        @routes = Route.all.sort_by{|route| route.duration}
      else
        @routes = Route.all.sort_by{|route| route.duration}.reverse
      end
    else      
      @routes = Route.order(sort_column + ' ' + sort_direction)
    end
  end
  
  private
   def sort_column
      if params[:sort] == 'duration'
        "duration"
      else
        Route.column_names.include?(params[:sort]) ? params[:sort] : "depart"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
