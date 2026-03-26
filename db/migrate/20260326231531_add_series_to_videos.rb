class AddSeriesToVideos < ActiveRecord::Migration[8.0]
  def change
    add_reference :videos, :series, null: true, foreign_key: true
  end
end
