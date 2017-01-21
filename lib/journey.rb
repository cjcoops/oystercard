class Journey

PENALTY_FARE = 6
MINIMUM_FARE = 1

  attr_reader :entry_station, :exit_station
  attr_accessor :complete

  def initialize(station = nil)
    @entry_station = station
    @complete = false
  end

  def end(station)
    @exit_station = station
    self.complete = true
    self
  end

  def fare
    return PENALTY_FARE if penalty?
    1
  end

  def complete?
    complete
  end

  private

  def penalty?
    !entry_station || !exit_station
  end

end
