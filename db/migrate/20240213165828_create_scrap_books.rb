class CreateScrapBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :scrap_books do |t|
      t.integer :user_id, null: false
      t.text :comment
      t.timestamps
    end
  end
end
