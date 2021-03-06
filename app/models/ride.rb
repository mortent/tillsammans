class Ride < ActiveRecord::Base
  belongs_to :event
  belongs_to :location
  has_many :passengers, :dependent => :destroy
  
  validates_presence_of :event, :location, :number_of_seats
  validates_numericality_of :number_of_seats
  
  def add_passenger(user, is_organizer=false)
    return false unless available_seats?
    passengers << Passenger.create!(:ride => self, :user => user, :is_organizer => is_organizer)
  end
  
  def remove_passenger(user)
    keepers = []
    passengers.each do |passenger|
      if passenger.user == user 
        passenger.destroy 
        if passenger.is_organizer?
          self.passengers = []
          self.destroy
          return nil
        end
      else
        keepers << passenger
      end
    end
    self.passengers = keepers
  end
  
  def number_of_passengers
    passengers.size
  end
  
  def number_of_available_seats
    number_of_seats - number_of_passengers
  end
  
  def available_seats?
    number_of_available_seats > 0
  end
  
  def organizer
    passengers.each do |passenger|
      return passenger.user if passenger.is_organizer
    end
    nil
  end
  
  def has_user? user
    passengers.each do |passenger|
      return true if passenger.user == user
    end
    false
  end
end
