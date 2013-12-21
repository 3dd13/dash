class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :marker
      t.decimal :latitude, precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10
      t.references :locatable, polymorphic: true

    end

    add_index :locations, [ :locatable_id, :locatable_type ]
  end
end
