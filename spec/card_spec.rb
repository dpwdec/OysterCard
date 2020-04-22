require "card"

shared_context "topped up" do
  let(:subject) do
    subject = described_class.new
    subject.top_up(1)
    subject
  end
end

describe Card do

  let(:entry_station) { double() }
  let(:exit_station) { double() }

  context "when initialized" do
    it 'balance is 0' do
      expect( subject.balance ).to equal(0)
    end
  end

  context 'when balance is at max limit' do
    it '£1 top-up cant work' do
      max_balance = Card::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error "Top-up exceeds balance limit"
    end
  end

  context "when topped up" do
    include_context "topped up"

    describe '#top_up' do
        it '£10 top-up' do
          expect{ subject.top_up(10) }.to change { subject.balance }.from(1).to(11)
        end
    end

    describe '#tap_in' do
        it 'is in a journey?' do
          expect { subject.tap_in(entry_station) }.to change { subject.in_journey? }.to true
        end
        it 'is not in a journey?' do
          subject.tap_in(entry_station)
          expect { subject.tap_out(exit_station) }.to change { subject.in_journey? }.to false
        end
        it 'adds entry_station to journeys' do
          expect { subject.tap_in(entry_station) }.to change { subject.journeys }.to include({:entry_station => entry_station, :exit_station => nil})
        end
    end

    describe '#tap_out' do
        it 'minimum balance is deducted' do
          min_balance = Card::MIN_BALANCE
          subject.tap_in(entry_station)
          expect { subject.tap_out(exit_station) }.to change { subject.balance }.by(-min_balance)
        end
        it 'a completed journey is added to journeys' do
          subject.tap_in(entry_station)
          expect { subject.tap_out(exit_station) }.to change { subject.journeys.last[:exit_station] }.from(nil).to(exit_station)
        end
    end
  end

  context 'when not topped up' do
    describe '#tap_in' do
      it 'cant tap-in if minimum balance is not met' do
        min_balance = Card::MIN_BALANCE
        expect { subject.tap_in(entry_station) }.to raise_error "Insufficient funds: min. £#{min_balance} required"
      end
    end
  end

  context 'when 2 journeys completed' do
    it 'cards shows previous journeys' do
      expect(subject.journeys).to be_a_kind_of Array
    end
  end

end
