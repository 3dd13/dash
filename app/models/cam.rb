class Cam < ActiveRecord::Base
  has_many :slots, dependent: :destroy
  has_many :dashboards, through: :slots
  has_one :location, as: :locatable, dependent: :destroy

  accepts_nested_attributes_for :location

  delegate :address, :latitude, :longitude, to: :location
end
