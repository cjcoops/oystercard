require 'card.rb'

describe Oystercard do

  subject(:card) { described_class.new }
  let(:first_station) { double :station }
  let(:second_station) { double :station }
  let(:journey){ Journey.new(first_station) }


  describe "#initialization" do

    it 'starts with a balance of 0' do
      expect(card.balance).to eq 0
    end

  end

  it { is_expected.to respond_to(:touch_in).with(1).argument }

  it { is_expected.to respond_to(:touch_out).with(1).argument }

  describe "#top_up" do

    it "should test that balance will change due to amount added" do
      expect{ card.top_up 10 }.to change{ card.balance }.by 10
    end

    it "should raise error if balance is more than 90" do
      maximum_top_up = described_class::MAXIMUM_BALANCE
      card.top_up(maximum_top_up)
      expect{card.top_up(100)}.to raise_error("Cannot top up: balance capacity of #{maximum_top_up} has been exceeded")
    end

  end

  describe "#touch_in" do

    it "should raise error if balance is below 1 pound" do
      expect{card.touch_in(first_station)}.to raise_error("Cannot touch in: not enough funds")
    end

  end


  context 'card is topped up' do

    before do
      card.top_up(described_class::MAXIMUM_BALANCE)
    end

    describe "#touch_in" do

      it "should create a new journey with entry_station" do
        card.touch_in(first_station)
        expect(journey.entry_station).to eq first_station
      end

    end

    describe "#touch_out" do

      it "should test that minimum value is deducted from card at touch out" do
        card.touch_in(first_station)
        expect{ card.touch_out(second_station) }.to change{ card.balance }.by(-described_class::MINIMUM_CHARGE)
      end

      it "should get minimum fare when in complete journey" do
        card.touch_in(first_station)
        card.touch_out(second_station)
        expect(card.balance).to eq(described_class::MAXIMUM_BALANCE - described_class::MINIMUM_CHARGE)
      end

      it "should get penalty fare when in incomplete journey" do
        card.touch_out(second_station)
        expect(card.balance).to eq(described_class::MAXIMUM_BALANCE - 6)
      end

    end

  end

end
