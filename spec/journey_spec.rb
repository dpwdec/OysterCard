require 'journey'

describe Journey do

  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:exit_station) }

  describe "#complete?" do

    let(:entry_station) { double() }
    let(:exit_station) { double() }

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

end
