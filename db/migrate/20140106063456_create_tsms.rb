class CreateTsms < ActiveRecord::Migration
  def change
    create_table :tsms do |t|
      t.string :name
      t.string :region
      t.string :road_type
      t.decimal :speed

      t.timestamps
    end
    add_index :tsms, :name
  end
end
