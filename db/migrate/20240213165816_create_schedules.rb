class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
      t.string :title, null: false
      t.text :body
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.timestamps
    end
  end
end
