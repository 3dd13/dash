class CreateCams < ActiveRecord::Migration
  def change
    create_table :cams do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
