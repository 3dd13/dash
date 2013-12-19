class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :slots, dependent: :destroy
  has_many :cams, through: :slots
end
