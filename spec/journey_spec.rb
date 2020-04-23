require 'journey'

describe Journey do

  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:exit_station) }

  let(:entry_station) { double() }
  let(:exit_station) { double() }

  describe "#complete?" do

    it "returns false if exit_station or entry_station are not nil" do
      subject.entry_station = entry_station
      subject.exit_station = exit_station
      expect(subject.complete?).to be true
    end

    it "returns true if exit_station is nil" do
      subject.entry_station = entry_station
      expect(subject.complete?).to be false
    end

    it "returns true if entry_station is nil" do
      subject.exit_station = exit_station
      expect(subject.complete?).to be false
    end
  end

  describe "#fare" do
    it 'returns a minimum fare of 1 for a complete journey' do
      subject.entry_station = entry_station
      subject.exit_station = exit_station
      expect(subject.fare).to eq(1)
    end

    it 'does not return a charge if journey is incomplete' do
      subject.entry_station = entry_station
      expect(subject.fare).to eq(0)
    end
  end

end
