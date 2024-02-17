class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
      t.string :title, null: false
      t.text :body
      t.datetime :start_time
      t.datetime :finish_time
      t.boolean :is_all_day, default: false
      t.timestamps
    end
  end
end
