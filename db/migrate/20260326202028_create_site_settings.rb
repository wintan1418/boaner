class CreateSiteSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :site_settings do |t|
      t.string :site_name
      t.string :tagline
      t.string :hero_heading
      t.text :hero_subheading
      t.text :bio_short
      t.text :bio_long
      t.string :youtube_url
      t.string :twitter_url
      t.string :instagram_url
      t.string :linkedin_url
      t.string :email

      t.timestamps
    end
  end
end
