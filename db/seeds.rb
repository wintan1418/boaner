puts "Seeding database..."

# Videos (real YouTube IDs for valid thumbnails)
videos = [
  { title: "The Art of Storytelling", youtube_id: "Nj-hdQMa3uA", description: "What makes a story truly captivating? In this video, I break down the essential elements of great storytelling.", category: "Story", published_at: 3.days.ago, featured: true },
  { title: "How to Read More Books This Year", youtube_id: "lIW5jBrrsS0", description: "Practical strategies I use to read 50+ books a year without burning out.", category: "Lecture", published_at: 1.week.ago, featured: true },
  { title: "Why I Write Every Day", youtube_id: "UoEqGMIbbsg", description: "The daily writing habit that changed my life and how you can build one too.", category: "Story", published_at: 2.weeks.ago, featured: true },
  { title: "Lessons from Teaching for 10 Years", youtube_id: "5MgBikgcWnY", description: "A decade in the classroom taught me more than any book could.", category: "Lecture", published_at: 3.weeks.ago, featured: false },
  { title: "My Morning Routine for Creativity", youtube_id: "dQw4w9WgXcQ", description: "How I structure my mornings to maximize creative output.", category: "Vlog", published_at: 1.month.ago, featured: false },
  { title: "The Power of Quiet Reflection", youtube_id: "RcYjXbSJBN8", description: "In a noisy world, the ability to sit quietly with your thoughts is a superpower.", category: "Story", published_at: 5.weeks.ago, featured: false },
]

videos.each do |v|
  video = Video.find_or_initialize_by(youtube_id: v[:youtube_id])
  video.assign_attributes(v)
  video.save!
end
puts "  #{Video.count} videos"

# Posts
posts = [
  { title: "The Stories We Tell Ourselves", slug: "stories-we-tell-ourselves", excerpt: "Every person carries a narrative about who they are. But what happens when that story no longer serves us?", category: "Essay", published_at: 2.days.ago, featured: true },
  { title: "Notes on Teaching in the Digital Age", slug: "teaching-digital-age", excerpt: "The classroom has changed dramatically. Here's what I've learned about connecting with students in a world of endless distraction.", category: "Opinion", published_at: 1.week.ago, featured: true },
  { title: "A Letter to My Younger Self", slug: "letter-to-younger-self", excerpt: "If I could go back and tell my 20-year-old self one thing, it would be this...", category: "Story", published_at: 2.weeks.ago, featured: false },
  { title: "Why Books Still Matter", slug: "why-books-still-matter", excerpt: "In the age of short-form content, the long-form book remains our most powerful tool for deep understanding.", category: "Essay", published_at: 3.weeks.ago, featured: false },
]

posts.each do |p|
  post = Post.find_or_initialize_by(slug: p[:slug])
  post.assign_attributes(p)
  post.save!
  post.update!(body: "<p>#{p[:excerpt]}</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p><p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><h2>The Key Insight</h2><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>") unless post.body.present?
end
puts "  #{Post.count} posts"

# Courses
course1 = Course.find_or_initialize_by(slug: "creative-writing-fundamentals")
course1.assign_attributes(title: "Creative Writing Fundamentals", description: "A comprehensive course covering the basics of creative writing — from finding your voice to crafting compelling narratives.", published: true)
course1.save!

lessons1 = [
  { title: "Finding Your Voice", position: 1, free_preview: true },
  { title: "Character Development", position: 2, free_preview: true },
  { title: "Plot Structure & Story Arcs", position: 3, free_preview: false },
  { title: "Writing Dialogue", position: 4, free_preview: false },
  { title: "Editing & Revision", position: 5, free_preview: false },
]

lessons1.each do |l|
  lesson = course1.lessons.find_or_initialize_by(position: l[:position])
  lesson.assign_attributes(l)
  lesson.save!
  lesson.update!(body: "<p>Welcome to <strong>#{l[:title]}</strong>. In this lesson, we'll explore the fundamental concepts and practical techniques you need to master.</p><h2>Key Concepts</h2><p>Every great writer starts with understanding the basics. Let's dive into what makes this topic essential for your writing journey.</p><p>Practice is the key to mastery. Try the exercises at the end of this lesson to solidify your understanding.</p>") unless lesson.body.present?
end

course2 = Course.find_or_initialize_by(slug: "public-speaking-mastery")
course2.assign_attributes(title: "Public Speaking Mastery", description: "Learn how to captivate any audience — from university lectures to keynote presentations.", published: true)
course2.save!

lessons2 = [
  { title: "Overcoming Stage Fright", position: 1, free_preview: true },
  { title: "Structuring Your Talk", position: 2, free_preview: false },
  { title: "Engaging Your Audience", position: 3, free_preview: false },
]

lessons2.each do |l|
  lesson = course2.lessons.find_or_initialize_by(position: l[:position])
  lesson.assign_attributes(l)
  lesson.save!
  lesson.update!(body: "<p>Welcome to <strong>#{l[:title]}</strong>. This lesson covers practical strategies you can apply immediately.</p><h2>Core Principles</h2><p>Great speakers aren't born — they're made through deliberate practice and understanding of key principles.</p>") unless lesson.body.present?
end
puts "  #{Course.count} courses with #{Lesson.count} lessons"

# Books
books = [
  { title: "Echoes of Tomorrow", description: "A collection of short stories exploring the intersection of memory, identity, and the choices that define us.", published_year: 2024, buy_url: "https://amazon.com" },
  { title: "The Reluctant Storyteller", description: "A memoir about finding your voice in a world that doesn't always want to listen.", published_year: 2022, buy_url: "https://amazon.com" },
  { title: "Teaching with Heart", description: "Lessons learned from a decade of teaching — a practical guide for educators who want to make a difference.", published_year: 2020, buy_url: "https://amazon.com" },
]

books.each do |b|
  book = Book.find_or_initialize_by(title: b[:title])
  book.assign_attributes(b)
  book.save!
end
puts "  #{Book.count} books"

# Sample approved comments
if Comment.count == 0
  video = Video.first
  video.comments.create!(name: "Sarah M.", body: "This really resonated with me. Your storytelling is incredible!", approved: true)
  video.comments.create!(name: "James K.", body: "Just discovered your channel. Subscribed immediately!", approved: true)

  post = Post.first
  post.comments.create!(name: "Alex R.", body: "Beautiful essay. The part about rewriting our personal narratives was particularly powerful.", approved: true)
  puts "  #{Comment.count} comments"
end

# Site Settings
SiteSetting.instance
puts "  Site settings initialized"

puts "Done!"
if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end
end