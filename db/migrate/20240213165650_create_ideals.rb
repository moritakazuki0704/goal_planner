class CreateIdeals < ActiveRecord::Migration[6.1]
  def change
    create_table :ideals do |t|
      t.integer :user_id , null: false
      t.integer :ideal_status, default: "0", null: false
      t.text :ideal_self, null: false
      t.timestamps
    end
  end
end
