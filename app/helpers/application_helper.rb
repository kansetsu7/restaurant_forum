module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column
    if column == sort_column && sort_direction == 'asc'
      direction = 'desc'
      icon_direction = ""
    else
      direction = 'asc'
      icon_direction = "-alt"
    end

    if column == sort_column
      link_to("#{column.capitalize}<span class='glyphicon glyphicon-sort-by-alphabet#{icon_direction}'></span>".html_safe, :sort => column, :direction => direction)
    else
      link_to(column.capitalize, :sort => column, :direction => direction)
    end
  end

end
