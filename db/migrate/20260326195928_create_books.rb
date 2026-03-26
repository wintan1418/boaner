class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :cover_image
      t.string :buy_url
      t.integer :published_year

      t.timestamps
    end
  end
end
