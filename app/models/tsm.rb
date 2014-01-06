require 'open-uri'

class Tsm < ActiveRecord::Base
  has_one :start_location, ->{ where marker: 'A' }, class_name: "Location", as: :locatable, dependent: :destroy
  has_one :end_location, ->{ where marker: 'B' }, class_name: "Location", as: :locatable, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :start_location
  accepts_nested_attributes_for :end_location

  def self.refresh
    doc = Nokogiri::XML(open('http://data.one.gov.hk/others/td/speedmap.xml'))
    doc.search('jtis_speedmap').each do |t|
      link_id               = t.at('LINK_ID').text
      region                = t.at('REGION').text
      road_type             = t.at('ROAD_TYPE').text
      road_saturation_level = t.at('ROAD_SATURATION_LEVEL').text
      traffic_speed         = t.at('TRAFFIC_SPEED').text
      capture_date          = t.at('CAPTURE_DATE').text

      self.find_by_name(link_id).update(
        road_saturation_level: road_saturation_level,
        traffic_speed: traffic_speed,
        capture_date: capture_date)
    end

  end

end
