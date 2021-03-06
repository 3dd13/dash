class CreateTsms < ActiveRecord::Migration
  def change
    create_table :tsms do |t|
      t.string    :name
      t.string    :region
      t.string    :road_type
      t.string    :road_saturation_level
      t.decimal   :traffic_speed
      t.datetime  :capture_date

      t.timestamps
    end
    add_index :tsms, :name
  end
end
