class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :slots, dependent: :destroy
  has_many :cams, through: :slots

  has_one :point_a, ->{ where marker: 'A' }, class_name: "Location", as: :locatable, dependent: :destroy
  has_one :point_b, ->{ where marker: 'B' }, class_name: "Location", as: :locatable, dependent: :destroy

  accepts_nested_attributes_for :point_a
  accepts_nested_attributes_for :point_b
end
