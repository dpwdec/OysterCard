require 'journey'

describe Journey do

  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:exit_station) }

  describe "#complete?" do
    it "returns false if exit_station or entry_station are nil" do

    end
  end

end
