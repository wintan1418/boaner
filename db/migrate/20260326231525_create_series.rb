class CreateSeries < ActiveRecord::Migration[8.0]
  def change
    create_table :series do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
