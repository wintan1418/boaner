xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title @settings.site_name
    xml.description @settings.tagline
    xml.link root_url
    xml.tag! "atom:link", href: feed_url(format: :rss), rel: "self", type: "application/rss+xml"
    xml.language "en"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.excerpt
        xml.pubDate post.published_at.to_fs(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
