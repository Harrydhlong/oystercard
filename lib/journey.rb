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
    if (@entry_station = entry_station && @exit_station = exit_station)
      @complete = true
    else
      @complete = false
    end
  end

  def fare
    if @exit_station = exit_station
      1
    else
      PENALTY_FARE
    end
  end

  def finish(exit_station)
    @exit_station = exit_station
    self
  end
end