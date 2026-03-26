module ApplicationHelper
  def nav_link(text, path)
    active = current_page?(path)
    classes = if active
      "px-3 py-1.5 text-sm font-semibold text-amber-600 nav-link-hover active"
    else
      "px-3 py-1.5 text-sm font-medium text-gray-600 hover:text-amber-600 nav-link-hover transition-colors"
    end
    link_to text, path, class: classes
  end

  def mobile_nav_link(text, path)
    active = current_page?(path)
    classes = if active
      "block px-4 py-3 text-sm font-semibold text-amber-600 bg-amber-50 rounded-lg"
    else
      "block px-4 py-3 text-sm font-medium text-gray-600 hover:text-amber-600 hover:bg-amber-50 rounded-lg transition-colors"
    end
    link_to text, path, class: classes
  end
end
