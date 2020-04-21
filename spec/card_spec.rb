require "card"

describe Card do
  # new_card = Card.new
  it "starts with 0 balance" do
    expect( subject.balance ).to equal(0)
  end

  it 'top-up of £10 incr balance by £10' do
    expect{ subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it '£1 top-up wont work if max balance is exceeded' do
    max_balance = Card::MAX_BALANCE
    subject.top_up(max_balance)
    expect { subject.top_up(1) }.to raise_error "Top-up exceeds balance limit"
  end

  it 'Person is in a journey if card is tapped in & has min. balance' do
    subject.top_up(1)
    expect { subject.tap_in }.to change { subject.in_journey }.to true
  end

  it 'Person is NOT in a journey if card is tapped out' do
    subject.top_up(1)
    subject.tap_in
    expect { subject.tap_out }.to change { subject.in_journey }.to false
  end

  it 'cant tap in if insufficient funds' do
    min_balance = Card::MIN_BALANCE
    expect { subject.tap_in }.to raise_error "Insufficient funds: min. £#{min_balance} required"
  end

end
