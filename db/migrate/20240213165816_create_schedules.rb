class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
      t.string :title, null: false
      t.text :body
      t.date :start_date
      t.time :start_time
      t.date :end_date
      t.time :end_time
      t.timestamps
    end
  end
end
