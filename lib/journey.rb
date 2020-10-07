require_relative 'oystercard'

class Journey
  PENALTY_FARE = 6

  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys

  def initialize(station = entry_station)
    @journeys = {}
    @complete = false
    @entry_station = station
  end

  def complete?
    @complete
  end

  def fare
    PENALTY_FARE
  end

  def finish(exit_station)
    self
  end
end