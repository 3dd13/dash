class CreateCams < ActiveRecord::Migration
  def change
    create_table :cams do |t|
      t.string :location
      t.decimal :longitude
      t.decimal :latitude
      t.string :uri

      t.timestamps
    end
  end
end
