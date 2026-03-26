module ApplicationHelper
  def nav_link(text, path)
    active = current_page?(path)
    classes = if active
      "text-ink-900 font-medium"
    else
      "text-ink-400 hover:text-ink-800 transition-colors"
    end
    link_to text, path, class: classes
  end

  def mobile_nav_link(text, path)
    active = current_page?(path)
    classes = if active
      "block px-3 py-2 text-sm font-medium text-ink-900"
    else
      "block px-3 py-2 text-sm text-ink-500 hover:text-ink-800"
    end
    link_to text, path, class: classes
  end

  def serif(text)
    content_tag(:span, text, style: "font-family: 'Source Serif 4', Georgia, serif;")
  end
end
