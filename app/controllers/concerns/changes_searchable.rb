module ChangesSearchable
  extend ActiveSupport::Concern

  private

    def set_changes
      routes_on_date = Route.depart(params[:depart])
      find_all_changes(params[:start_point], params[:end_point], routes_on_date)
      delete_straight_route
      appropriate_time_filter
      @changes
    end

    def find_all_changes(start_point, end_point, routes)
      @changes = []
      path_stack = [[]]
      while path_stack.any?
        current_path = path_stack.shift
        if current_path.present? && current_path.last.end_point == end_point
          @changes.push current_path
        else
          if current_path.present?
            last_point_children = routes.select{ |route| route.start_point == current_path.last.end_point }
          else
            last_point_children = routes.select{ |route| route.start_point == start_point }
          end
          last_point_children.each do |child_point|
            if current_path.present?
              if current_path.none?{ |route| route.end_point == child_point.end_point }
                path_stack.push current_path + [child_point]
              end
            else
              path_stack.push current_path + [child_point]
            end
          end
        end
      end
      @changes
    end

    def delete_straight_route
      @changes.delete_if{ |change| change.size == 1 }
    end

    def appropriate_time_filter
      unappropriate_routes = []
      @changes.each do |change|
          (change.length-1).times do |n|
            if change[n+1].depart - change[n].arrive < 25.minutes
              unappropriate_routes << change
            end
          end
      end
      @changes -= unappropriate_routes
    end

end
