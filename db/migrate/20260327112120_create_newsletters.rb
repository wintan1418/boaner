class CreateNewsletters < ActiveRecord::Migration[8.0]
  def change
    create_table :newsletters do |t|
      t.string :subject
      t.text :body
      t.datetime :sent_at
      t.integer :recipients_count

      t.timestamps
    end
  end
end
