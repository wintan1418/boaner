class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.references :commentable, polymorphic: true, null: false
      t.boolean :approved

      t.timestamps
    end
  end
end
