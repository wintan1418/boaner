class SiteSetting < ApplicationRecord
  has_one_attached :profile_image
  has_one_attached :hero_background

  def self.instance
    first_or_create!(
      site_name: "Boaner",
      tagline: "YouTuber. Lecturer. Writer.",
      hero_heading: "Words, stories, and ideas — shared with intention.",
      hero_subheading: "I make videos, teach courses, and write books. This is where all of that lives.",
      bio_short: "A storyteller, educator, and writer exploring ideas through video, the classroom, and the written word.",
      bio_long: "My work spans YouTube, university lectures, and published books. I believe in the power of a well-told story and the quiet discipline of putting words on a page. Whether I'm behind a camera, at a lectern, or at my desk — the goal is the same: to share something worth your time.",
      email: "hello@boaner.com"
    )
  end
end
