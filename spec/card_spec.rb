require "card"

describe Card do
  new_card = Card.new
  it "new instance of Card starts with 0 balance" do
    expect(new_card.balance).to equal(0)
  end

  it 'cant top up with negative number' do
    expect{ new_card.top_up(-5) }.to raise_error "Enter a positive number"
  end

  it 'top-up of £10 incr balance by £10' do
    expect{ new_card.top_up(10) }.to change { new_card.balance }.by(10)
  end

  it '£1 top-up wont work if max balance is exceeded' do
    max_balance = Card::MAXIMUM_BALANCE
    new_card.top_up(max_balance)
    expect { new_card.top_up(1) }.to raise_error "Top-up exceeds limit"
  end

  it 'Person is in a journey if card is tapped in' do
    expect { new_card.tap_in }.to change { new_card.in_journey }.from(false).to(true)
  end

  it 'Person is NOT in a journey if card is tapped out' do
    expect { new_card.tap_out }.to change { new_card.in_journey }.from(true).to(false)
  end

end
