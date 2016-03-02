module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize

    icon_value = column == sort_column ? "#{sort_direction}" : nil
    icon_class = { 'asc' => 'arrow-up',
                           'desc' => 'arrow-down',
                           nil => 'sort' }[icon_value]

    direction = sort_direction == "asc" ? "desc" : "asc"

    link_to root_path(params.merge(sort: column, direction: direction).symbolize_keys),
      remote: true do
      "#{title} &nbsp; <i class='glyphicon glyphicon-#{icon_class}'></i>".html_safe
    end
  end

end
