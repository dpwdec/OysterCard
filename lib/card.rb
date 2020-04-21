class Card
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :in_journey

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Top-up exceeds balance limit" if @balance + amount > MAX_BALANCE
      @balance += amount
  end

  def tap_in
    fail "Insufficient funds: min. £#{MIN_BALANCE} required" if @balance < MIN_BALANCE
    @in_journey = true
  end

  def tap_out
    deduct_fare
    @in_journey = false
  end

  private
  def deduct_fare
    @balance -= MIN_BALANCE
  end

end
