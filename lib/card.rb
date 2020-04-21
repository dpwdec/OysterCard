class Card
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :in_journey
  
  def initialize(balance=0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount_str)
    amount = amount_str.to_i
    fail "Enter a positive number" if amount < 0
    fail "Top-up exceeds limit" if @balance + amount > MAXIMUM_BALANCE
      @balance += amount
  end

  def tap_in
    @in_journey = true
  end

  def tap_out
    @in_journey = false
  end

end
