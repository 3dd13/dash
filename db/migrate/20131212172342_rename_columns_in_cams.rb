class RenameColumnsInCams < ActiveRecord::Migration
  def change
    rename_column :cams, :longitude, :tmp
    rename_column :cams, :latitude, :longitude
    rename_column :cams, :tmp, :latitude
  end
end
