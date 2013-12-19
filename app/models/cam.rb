class Cam < ActiveRecord::Base
  has_many :slots, dependent: :destroy
  has_many :dashboards, through: :slots
end
