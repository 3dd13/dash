class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true

  geocoded_by :address
  before_validation :geocode, if: :needs_geocoding?

  validates :latitude,
  presence: true,
  :numericality => {
    :greater_than_or_equal_to => -90.0,
    :less_than_or_equal_to => +90.0
  }

  validates :longitude,
  presence: true,
  :numericality => {
    :greater_than_or_equal_to => -180.0,
    :less_than_or_equal_to => +180.0
  }

  def to_latlng
    { lat: latitude, lng: longitude }
  end

  private
  def needs_geocoding?
    address && !(latitude && longitude)
  end
end
