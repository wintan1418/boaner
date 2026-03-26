module ApplicationHelper
  def nav_link(text, path)
    active = current_page?(path)
    classes = if active
      "px-3 py-1.5 text-sm font-medium text-stone-900 rounded-md bg-stone-100"
    else
      "px-3 py-1.5 text-sm text-stone-500 hover:text-stone-900 rounded-md hover:bg-stone-50 transition-colors"
    end
    link_to text, path, class: classes
  end

  def mobile_nav_link(text, path)
    active = current_page?(path)
    classes = if active
      "block px-3 py-2.5 text-sm font-medium text-stone-900 bg-stone-50 rounded-md"
    else
      "block px-3 py-2.5 text-sm text-stone-600 hover:text-stone-900 hover:bg-stone-50 rounded-md transition-colors"
    end
    link_to text, path, class: classes
  end
end
