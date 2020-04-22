class Card
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :in_journey, :entry_station

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Top-up exceeds balance limit" if @balance + amount > MAX_BALANCE
      @balance += amount
  end

  def tap_in(entry_station)
    fail "Insufficient funds: min. £#{MIN_BALANCE} required" if @balance < MIN_BALANCE
    @in_journey = true
    @entry_station = entry_station
  end

  def tap_out
    deduct_fare
    @in_journey = false
    @entry_station = nil
  end

  private
  def deduct_fare
    @balance -= MIN_BALANCE
  end

end
