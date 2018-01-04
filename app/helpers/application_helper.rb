module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column
    if column == current_title && sort_direction == 'asc'
      direction = 'desc'
      icon_direction = ''
    else
      direction = 'asc'
      icon_direction = "-alt"
    end

    if column == current_title
      link_to("#{column}<span class='glyphicon glyphicon-sort-by-alphabet#{icon_direction}'></span>".html_safe, :sort => column, :direction => direction)
    else
      link_to(column.capitalize, :sort => column, :direction => direction)
    end
  end

  def sort_name(current_direction)

    if current_direction == 'asc'
      direction = 'desc'
      icon_direction = ''
    else
      direction = 'asc'
      icon_direction = "-alt"
    end

    if current_page?(root_url)
      return link_to("Sort<span class='glyphicon glyphicon-sort-by-alphabet#{icon_direction}'></span>".html_safe, root_path(:direction => direction), class: "btn btn-default") 

    elsif current_page?(controller: 'categories', action: 'show')
      link_to("Sort<span class='glyphicon glyphicon-sort-by-alphabet#{icon_direction}'></span>".html_safe, category_path(:id => get_id, :direction => direction), class: "btn btn-default")
    
    end
    
  end

  def clearfixer(i)
    return '<div class="clearfix hidden-xs"></div>'.html_safe if i == 5
    if i.odd?
      '<div class="clearfix hidden-xs hidden-md hidden-lg"></div>'.html_safe
    elsif (i + 1 ) % 3 == 0
      '<div class="clearfix hidden-xs hidden-sm"></div>'.html_safe
    end
  end

  def show_restaurant_img(img, css_class = "img-responsive center-block")
    for img_id in 0..20
      include_path = '/'+img_id.to_s+'.jpg'
      return image_tag(('/seed_img'+include_path), class: css_class) if image_path(img).include?(include_path)
    end
    '<span class="glyphicon glyphicon-picture"></span>[沒有圖片]'.html_safe
  end

  def show_avatar(img)
    for img_id in 1..7
      include_path = '/avatar'+img_id.to_s+'.jpg'
      return image_tag(('/avatar'+include_path), class: "img-responsive center-block avatar") if image_path(img).include?(include_path)
    end
    image_tag('avatar.svg', class: 'fake-avatar')
  end

  def show_navtabs(tab)

    if ((current_page?(controller: 'restaurants', action: 'feed') && tab == 'feed') || 
      (current_page?(root_path) && tab == 'root') || 
      (current_page?(controller: 'restaurants', action: 'ranking') && tab == 'ranking')) ||
      (is_categories_show? && tab == 'root')
      return '<li role=presentation class=active>'.html_safe
    end

    '<li role=presentation>'.html_safe

  end

  def show_username_link(user)
    user.nil? ? '[帳號已被刪除]' : link_to(user.name, user_path(user.id))
  end

  def show_category_name(category)
    category.nil? ? '[未分類]' : category.name
  end

  def is_categories_show?
    (params[:controller] == 'categories' && params[:action] == 'show' && Category.ids.include?(params[:id].to_i)) ? true : false
  end

end
