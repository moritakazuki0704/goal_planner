class CreateIdeals < ActiveRecord::Migration[6.1]
  def change
    create_table :ideals do |t|
      t.integer :user_id , null: false
      t.string :keyword_1, null: false
      t.string :keyword_2, null: false
      t.string :keyword_3, null: false
      t.string :keyword_4, null: false
      t.string :keyword_5, null: false
      t.string :keyword_6, null: false
      t.string :keyword_7, null: false
      t.string :keyword_8, null: false
      t.string :keyword_9, null: false
      t.string :keyword_10, null: false
      t.text :personality_1, null: false
      t.text :personality_2, null: false
      t.text :personality_3, null: false
      t.text :hair_make, null: false
      t.text :body_make, null: false
      t.text :fashion_make, null: false
      t.text :lifestyle_1, null: false
      t.text :lifestyle_2, null: false
      t.text :lifestyle_3, null: false
      t.text :time_1, null: false
      t.text :time_2, null: false
      t.text :time_3, null: false
      t.text :working_1, null: false
      t.text :working_2, null: false
      t.text :working_3, null: false
      t.text :residence_1, null: false
      t.text :residence_2, null: false
      t.text :residence_3, null: false
      t.text :relationship_1, null: false
      t.text :relationship_2, null: false
      t.text :relationship_3, null: false
      t.text :partner_1, null: false
      t.text :partner_2, null: false
      t.text :partner_3, null: false
      t.text :partner_model, null: false
      t.text :family_model, null: false
      t.text :friend_model, null: false
      t.timestamps
    end
  end
end
