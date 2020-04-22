require "card"

shared_context "topped up" do
  let(:subject) do
    subject = described_class.new
    subject.top_up(1)
    subject
  end
end

describe Card do

  let(:station) { double() }
  # new_card = Card.new
  it "starts with 0 balance" do
    expect( subject.balance ).to equal(0)
  end

  it '£1 top-up wont work if max balance is exceeded' do
    max_balance = Card::MAX_BALANCE
    subject.top_up(max_balance)
    expect { subject.top_up(1) }.to raise_error "Top-up exceeds balance limit"
  end

  context "card is topped up" do
    include_context "topped up"
    it 'balance of £1 with top-up of £10 to incr balance to £11' do
      expect{ subject.top_up(10) }.to change { subject.balance }.from(1).to(11)
    end

    it 'is in a journey if card is tapped in & has min. balance' do
      expect { subject.tap_in(station) }.to change { subject.in_journey? }.to true
    end

    it 'is NOT in a journey if card is tapped out' do
      subject.tap_in(station)
      expect { subject.tap_out }.to change { subject.in_journey? }.to false
    end

    it 'on tapping out, minimum balance is deducted from £10 balance' do
      min_balance = Card::MIN_BALANCE
      subject.tap_in(station)
      expect { subject.tap_out }.to change { subject.balance }.by(-min_balance)
    end

    it "remembers entry_station on tap_in" do
      expect { subject.tap_in(station) }.to change { subject.entry_station }.to eq(station)
    end

    it "changes entry_station to be nil on tap_out" do
      subject.tap_in(station)
      expect { subject.tap_out }.to change { subject.entry_station }.to be nil
    end
  end

  it 'cant tap in if insufficient funds' do
    min_balance = Card::MIN_BALANCE
    expect { subject.tap_in(station) }.to raise_error "Insufficient funds: min. £#{min_balance} required"
  end

end
