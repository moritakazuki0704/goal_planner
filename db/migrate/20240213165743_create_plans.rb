class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.integer :schedule_id , null: false
      t.string :challenge, null: false
      t.integer :priority_status, default: "0", null: false
      t.integer :progress_status, default: "0", null: false
      t.boolean :programme, default: false, null: false
      t.timestamps
    end
  end
end
