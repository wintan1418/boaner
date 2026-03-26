class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :excerpt
      t.string :category
      t.datetime :published_at
      t.boolean :featured

      t.timestamps
    end
  end
end
