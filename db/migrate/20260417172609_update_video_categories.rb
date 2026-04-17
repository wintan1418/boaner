class UpdateVideoCategories < ActiveRecord::Migration[8.0]
  def up
    execute "UPDATE videos SET category = 'Spiritual' WHERE category = 'Review'"
    execute "UPDATE videos SET category = 'Music' WHERE category = 'Video'"
  end

  def down
    execute "UPDATE videos SET category = 'Review' WHERE category = 'Spiritual'"
    execute "UPDATE videos SET category = 'Video' WHERE category = 'Music'"
  end
end
