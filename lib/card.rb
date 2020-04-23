class Card
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station

  def initialize(balance=0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    fail "Cannot top-up with negative amount" if amount < 0
    fail "Top-up exceeds balance limit" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def tap_in(entry_station)
    fail "Insufficient funds: min. £#{MIN_BALANCE} required" if @balance < MIN_BALANCE
    apply_entry_penalty
    @journeys.push(Journey.new(entry_station))
  end

  def tap_out(exit_station)
    if not apply_exit_penalty
      @journeys.last.exit_station = exit_station
      deduct(@journeys.last.fare)
    end
  end

  def in_journey?
    return false if @journeys.empty?
    return true if @journeys.last.exit_station == nil
    false
  end

  def journeys
    @journeys
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def apply_entry_penalty
    if !@journeys.empty?
      deduct(Journey::PENALTY_FARE) if not @journeys.last.complete?
    end
  end

  def apply_exit_penalty
    if @journeys.empty? || @journeys.last.complete?
      deduct(Journey::PENALTY_FARE)
      return true
    end
  end

  def current_journey
    @journeys.empty? ? Journey.new : @journeys.last
  end

end
