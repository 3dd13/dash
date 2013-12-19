class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :dashboard_id
      t.integer :cam_id

      t.timestamps
    end
    add_index :slots, :dashboard_id
    add_index :slots, :cam_id
  end
end
