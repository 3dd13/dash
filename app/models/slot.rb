class Slot < ActiveRecord::Base
  belongs_to :dashboard
  belongs_to :cam
end
