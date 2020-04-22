require 'station'

describe Station do

  let(:subject) { described_class.new("Paddington", 1) }

  describe "#name" do
    it "is a String" do
      expect(subject.name).to be_a_kind_of(String)
    end
  end

  describe "#zone" do
    it "is a Integer" do
      expect(subject.zone).to be_a_kind_of(Integer)
    end
  end

end
