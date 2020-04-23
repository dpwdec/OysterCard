class Journey

  attr_accessor :entry_station, :exit_station

  def complete?
    entry_station.nil? || exit_station.nil? ? false : true
  end

end
