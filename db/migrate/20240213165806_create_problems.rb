class CreateProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems do |t|
      t.integer :user_id, null: false
      t.string :commitment, null: false
      t.text :purpose, null: false
      t.integer :progress_status,default: "0"

      t.timestamps
    end
  end
end
