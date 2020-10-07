require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @journeys.has_key?(:entry_station) & !@journeys.has_key?(:exit_station)
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_BALANCE
    @journeys[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @journeys[:exit_station] = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end