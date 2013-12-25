class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true

  geocoded_by :address
  after_validation :geocode, if: :need_geocoding

  private
  def need_geocoding
    address && !(latitude && longitude)
  end
end
