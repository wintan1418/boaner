class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :youtube_id
      t.text :description
      t.string :category
      t.datetime :published_at
      t.boolean :featured

      t.timestamps
    end
  end
end
