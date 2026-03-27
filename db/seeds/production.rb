puts "Seeding production database..."

# Site Settings
settings = SiteSetting.instance
settings.update!(
  site_name: "Boaner",
  tagline: "YouTuber. Lecturer. Writer.",
  hero_heading: "Untold stories from history, told with intention.",
  hero_subheading: "Exploring the forgotten chapters of African and world history through video, lectures, and the written word.",
  bio_short: "A storyteller, educator, and writer exploring history through video, the classroom, and the written word.",
  bio_long: "I believe the best stories are the ones history tried to forget. Through my YouTube channel, university lectures, and published books, I bring forgotten narratives back to life — from the Black Pharaohs of Egypt to the untold revolutions that shaped our world.",
  email: "hello@boaner.com",
  youtube_channel_id: "UCJ_Q6U3hzPkt46jkwl-x_VA",
  youtube_url: "https://youtube.com/@HistovraLive"
)
puts "  Site settings configured"

# Videos from HistovraLive
videos_data = [
  { youtube_id: "y84JXjTCa-M", title: "I Studied the MOST TYRANNICAL Rulers in History and Here's What I Found", description: "We have curated a journey through the minds of 30 of history's most dangerous egos. We are launching a massive, 10-part series right here on this channel, breaking down narcissistic leaders.", category: "History", published_at: 1.day.ago, featured: true },
  { youtube_id: "UoHES8e4Ri8", title: "Who Were Egypt's Black Pharaohs? The African Kings Who Reunited an Empire", description: "Forget everything you thought you knew about ancient Egypt! For over a century, powerful Nubian kings from the south — the legendary black pharaohs — ruled the land of the Nile.", category: "History", published_at: 4.days.ago, featured: true },
  { youtube_id: "sBn2U-7ad9M", title: "Beyond Atlantis | Unearthing the REAL Lost Cities of the Mediterranean", description: "Forget the myth of Atlantis! While Plato's legendary island remains a captivating tale, the Mediterranean Sea holds far more tangible and astonishing secrets.", category: "History", published_at: 7.days.ago, featured: true },
  { youtube_id: "ATPx_VSP9G4", title: "The Lost Colony of Roanoke | Solved or Still a Mystery?", description: "The Lost Colony of Roanoke: One of America's greatest unsolved mysteries. Imagine 115 English colonists, vanished without a trace from their settlement on Roanoke Island.", category: "History", published_at: 11.days.ago, featured: false },
  { youtube_id: "tT2aIuCNH8E", title: "The King Who Said YES When the World Said NO", description: "The world said NO. One king said YES. This is an untold history of a true story. In the middle of World War II, hundreds of Polish children — orphaned, starving, and rejected by every country.", category: "Story", published_at: 2.weeks.ago, featured: false },
  { youtube_id: "711UoCNBX7Q", title: "The Human Cost: Industrial Revolution's Dark Side (Part 2)", description: "Beyond the machines: The profound social changes and global spread of the Industrial Revolution.", category: "History", published_at: 2.weeks.ago, featured: false },
  { youtube_id: "4mPB70e13LA", title: "The Machine That Changed the World: Industrial Revolution Part 1", description: "The spark that ignited a global transformation: How textiles, iron, and steam remade Britain.", category: "History", published_at: 3.weeks.ago, featured: false },
  { youtube_id: "RJJcutxwwLE", title: "The Price of Freedom: America's Unfinished Revolution (Part 3)", description: "Beyond the battlefield: The complex legacy of America's fight for liberty.", category: "History", published_at: 3.weeks.ago, featured: false },
  { youtube_id: "90CjNlwJl5A", title: "Washington's Gamble: How America Won the Revolution (Part 2)", description: "The darkest hour and the turning tide: How America fought back and won the Revolution.", category: "History", published_at: 1.month.ago, featured: false },
  { youtube_id: "IWGZkqBAY-4", title: "The Shot That Started a Nation: American Revolution Part 1", description: "The spark that ignited a revolution: From 'no taxation' to 'give me liberty.'", category: "History", published_at: 1.month.ago, featured: false },
  { youtube_id: "gVqeXJ02wiA", title: "The Invention That Unleashed Electricity | Volta's Battery", description: "From fleeting sparks to continuous power: How Volta's battery ignited the electrical age.", category: "History", published_at: 1.month.ago, featured: false },
  { youtube_id: "m65lTgASpFc", title: "When Science Was Magic: The True Story of Electricity", description: "Before we understood it, we feared it. The story of the mad scientists who tamed the lightning.", category: "History", published_at: 1.month.ago, featured: false },
  { youtube_id: "8DJhYMmwIQI", title: "Roman Empire's Dark Secret | How Brutal Slavery & Exploitation Forged Its Golden Age", description: "The Roman Empire: a beacon of engineering, law, and culture. But what if we told you that behind every magnificent structure lay an ocean of human suffering?", category: "History", published_at: 2.months.ago, featured: false },
  { youtube_id: "Y7kOpjBKGI0", title: "Why Napoleon Lost to an Army of Slaves", description: "Napoleon betrayed them. So they destroyed his army. The brutal end of the Haitian Revolution.", category: "History", published_at: 2.months.ago, featured: false },
  { youtube_id: "E-hXKJhHPtQ", title: "The Revolutionary Ego: Mugabe, Amin & Gaddafi's Rule of Fear", description: "They started as liberators. They ended as tyrants. Exploring the psychology of powerful African leaders.", category: "History", published_at: 3.months.ago, featured: false },
  { youtube_id: "roN-9liq3u0", title: "The Narcissistic Rulers Who Destroyed Nations (Part 2)", description: "From Nero to Idi Amin — the pattern of narcissistic leadership and its devastating consequences.", category: "History", published_at: 3.months.ago, featured: false },
  { youtube_id: "HyKAX22nRok", title: "When Ego Rules: The Psychology of Tyrannical Power (Part 3)", description: "Understanding the psychological profile of leaders who put ego above everything.", category: "History", published_at: 3.months.ago, featured: false },
  { youtube_id: "mfjU_8oPwSI", title: "Narcissistic Rulers: The Fall of Empires (Part 4)", description: "How narcissistic leadership led to the collapse of some of history's greatest civilizations.", category: "History", published_at: 4.months.ago, featured: false },
  { youtube_id: "MetrlGclPJQ", title: "Narcissistic Rulers: Lessons History Teaches Us (Part 5)", description: "What can we learn from the patterns of narcissistic rulers throughout history?", category: "History", published_at: 4.months.ago, featured: false },
]

videos_data.each do |v|
  video = Video.find_or_initialize_by(youtube_id: v[:youtube_id])
  video.assign_attributes(v)
  video.save!
end
puts "  #{Video.count} videos"

# Series
series_data = [
  { title: "American Revolution", slug: "american-revolution", description: "A three-part deep dive into the birth of the United States.", position: 1,
    video_ids: %w[IWGZkqBAY-4 90CjNlwJl5A RJJcutxwwLE] },
  { title: "Industrial Revolution", slug: "industrial-revolution", description: "Exploring how the Industrial Revolution transformed the world.", position: 2,
    video_ids: %w[4mPB70e13LA 711UoCNBX7Q] },
  { title: "Narcissistic Rulers", slug: "narcissistic-rulers", description: "A multi-part series on history's most dangerous egos and what drives narcissistic leaders.", position: 3,
    video_ids: %w[E-hXKJhHPtQ roN-9liq3u0 HyKAX22nRok mfjU_8oPwSI MetrlGclPJQ y84JXjTCa-M] },
]

series_data.each do |s|
  yt_ids = s.delete(:video_ids)
  series = Series.find_or_initialize_by(slug: s[:slug])
  series.assign_attributes(s)
  series.save!
  yt_ids.each do |yt_id|
    video = Video.find_by(youtube_id: yt_id)
    video&.update!(series_id: series.id)
  end
end
puts "  #{Series.count} series"

# Blog Posts
posts_data = [
  { title: "The Stories History Tried to Forget", slug: "stories-history-tried-to-forget", excerpt: "Why do some narratives survive while others vanish? The answer tells us more about power than about truth.", category: "Essay", published_at: 3.days.ago, featured: true },
  { title: "What the Black Pharaohs Teach Us About Identity", slug: "black-pharaohs-identity", excerpt: "The Nubian kings who ruled Egypt challenge everything we think we know about civilization, race, and legacy.", category: "History", published_at: 1.week.ago, featured: true },
  { title: "On Teaching History in a Post-Truth World", slug: "teaching-history-post-truth", excerpt: "When everyone has their own version of events, how do we teach the next generation to think critically about the past?", category: "Opinion", published_at: 2.weeks.ago, featured: false },
  { title: "The Power of Oral Tradition in African Storytelling", slug: "oral-tradition-african-storytelling", excerpt: "Long before the written word, griots carried entire civilizations in their memory. Their legacy endures.", category: "Essay", published_at: 3.weeks.ago, featured: false },
]

posts_data.each do |p|
  post = Post.find_or_initialize_by(slug: p[:slug])
  post.assign_attributes(p)
  post.save!
  unless post.body.present?
    post.update!(body: "<p>#{p[:excerpt]}</p><p>History is not simply a record of what happened — it is a negotiation between memory and power. The stories that survive are not always the most important ones; they are the ones that served the interests of those who held the pen.</p><h2>Reclaiming the Narrative</h2><p>Across Africa and the diaspora, a quiet revolution is underway. Scholars, filmmakers, and storytellers are unearthing the buried chapters of our collective past, challenging the dominant narratives that have shaped our understanding of the world.</p><p>This work is not merely academic — it is deeply personal. When we recover a lost story, we recover a piece of ourselves.</p>")
  end
end
puts "  #{Post.count} posts"

# Courses
course1 = Course.find_or_initialize_by(slug: "african-history-untold")
course1.assign_attributes(title: "African History: The Untold Chapters", description: "A deep dive into the kingdoms, empires, and revolutions that shaped the African continent — from ancient Nubia to the independence movements of the 20th century.", published: true)
course1.save!

[
  { title: "Before the Colonial Gaze: Africa's Ancient Civilizations", position: 1, free_preview: true },
  { title: "The Kingdom of Kush and the Black Pharaohs", position: 2, free_preview: true },
  { title: "West African Empires: Mali, Songhai, and the Gold Trade", position: 3, free_preview: false },
  { title: "The Swahili Coast: Trade, Islam, and Cultural Exchange", position: 4, free_preview: false },
  { title: "Resistance and Revolution: The Fight for Independence", position: 5, free_preview: false },
].each do |l|
  lesson = course1.lessons.find_or_initialize_by(position: l[:position])
  lesson.assign_attributes(l)
  lesson.save!
  unless lesson.body.present?
    lesson.update!(body: "<p>Welcome to <strong>#{l[:title]}</strong>. In this lesson, we explore the historical forces and figures that shaped this pivotal chapter of African history.</p><h2>Key Themes</h2><p>Understanding history requires more than memorizing dates — it demands that we engage with the lived experiences of real people navigating extraordinary circumstances.</p><p>By the end of this lesson, you will have a deeper appreciation for the complexity and richness of this period.</p>")
  end
end

course2 = Course.find_or_initialize_by(slug: "the-art-of-historical-storytelling")
course2.assign_attributes(title: "The Art of Historical Storytelling", description: "Learn how to transform dry historical facts into compelling narratives that captivate audiences — whether on YouTube, in writing, or at the lectern.", published: true)
course2.save!

[
  { title: "Why Stories Matter: The Power of Narrative", position: 1, free_preview: true },
  { title: "Research Methods: Finding the Gold in the Archives", position: 2, free_preview: false },
  { title: "Structure and Pacing: Building Tension in Non-Fiction", position: 3, free_preview: false },
].each do |l|
  lesson = course2.lessons.find_or_initialize_by(position: l[:position])
  lesson.assign_attributes(l)
  lesson.save!
  unless lesson.body.present?
    lesson.update!(body: "<p>Welcome to <strong>#{l[:title]}</strong>. Great historical storytelling sits at the intersection of rigorous research and compelling narrative craft.</p><h2>Core Principles</h2><p>The best historical storytellers — from Robert Caro to Chimamanda Ngozi Adichie — share a common discipline: they let the evidence guide the story, but they never forget that readers and viewers are human beings who need to feel something.</p>")
  end
end
puts "  #{Course.count} courses with #{Lesson.count} lessons"

# Books
books_data = [
  { title: "Echoes of Empire", description: "A sweeping narrative of how African kingdoms rose, fell, and left indelible marks on the modern world.", published_year: 2024, buy_url: "https://amazon.com" },
  { title: "The Forgotten Revolution", description: "The untold story of the Haitian Revolution and why it matters more than ever.", published_year: 2022, buy_url: "https://amazon.com" },
  { title: "Voices from the Past", description: "A collection of oral histories from across the African continent, preserved for future generations.", published_year: 2020, buy_url: "https://amazon.com" },
]

books_data.each do |b|
  book = Book.find_or_initialize_by(title: b[:title])
  book.assign_attributes(b)
  book.save!
end
puts "  #{Book.count} books"

# Admin user
AdminUser.find_or_create_by!(email: "comungback2dfuture@gmail.com") do |admin|
  admin.password = "Boaner2026!"
  admin.password_confirmation = "Boaner2026!"
end
puts "  Admin user created (comungback2dfuture@gmail.com)"

puts "Done!"
