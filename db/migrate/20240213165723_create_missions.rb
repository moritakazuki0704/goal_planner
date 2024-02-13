class CreateMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :missions do |t|
      t.integer :commit_id, null: false
      t.string :memo, null: false
      t.timestamps
    end
  end
end
