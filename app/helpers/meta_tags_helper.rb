module MetaTagsHelper
  def meta_title(title = nil)
    content_for(:meta_title) || title || "#{@settings&.site_name || 'Boaner'} — #{@settings&.tagline}"
  end

  def meta_description(desc = nil)
    content_for(:meta_description) || desc || @settings&.bio_short || "YouTuber. Lecturer. Writer."
  end

  def meta_image(image = nil)
    content_for(:meta_image) || image || "https://images.unsplash.com/photo-1473163928189-364b2c4e1135?w=1200&h=630&auto=format&fit=crop"
  end

  def meta_url
    request.original_url
  end
end
