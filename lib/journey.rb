class Journey

  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def complete?
    entry_station.nil? || exit_station.nil? ? false : true
  end

  def fare
    complete? ? 1 : 0
  end

end
