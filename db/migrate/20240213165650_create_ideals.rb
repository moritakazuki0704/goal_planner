class CreateIdeals < ActiveRecord::Migration[6.1]
  def change
    create_table :ideals do |t|
      t.integer :user_id , null: false
      t.integer :ideal_status, default: "0", null: false
      t.text :ideal_self_1, null: false
      t.text :ideal_self_2, null: false
      t.text :ideal_self_3, null: false
      t.timestamps
    end
  end
end
