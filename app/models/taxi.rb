class Taxi < ActiveRecord::Base
  belongs_to :event
  belongs_to :location
  has_many :passengers
end
