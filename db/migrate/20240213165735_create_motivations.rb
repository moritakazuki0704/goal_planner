class CreateMotivations < ActiveRecord::Migration[6.1]
  def change
    create_table :motivations do |t|
      t.integer :user_id , null: false
      t.integer :emotion_status, default: "0", null: false
      t.text :appetite, null: false
      t.text :memory, null: false
      t.timestamps
    end
  end
end
