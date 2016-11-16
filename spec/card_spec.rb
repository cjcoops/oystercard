require 'card.rb'

describe Oystercard do

  subject(:card) { described_class.new }

  describe "#initialization" do

    it 'starts with a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'starts off not on a journey' do
      expect(subject.in_journey?).to eq false
    end

  end

  describe "#top_up" do

    it "should test that balance will change due to amount added" do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it "should raise error if balance is more than 90" do
      maximum_top_up = described_class::MAXIMUM_BALANCE
      subject.top_up(maximum_top_up)
      expect{subject.top_up(100)}.to raise_error("Cannot top up: balance capacity of #{maximum_top_up} has been exceeded")
    end

  end

  describe "#touch_in" do

    it "should raise error if balance is below 1 pound" do
      expect{subject.touch_in}.to raise_error("Cannot touch in: not enough funds")
    end

  end


  context 'card is topped up' do

    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in
    end

    describe "#touch_in" do

      it "should test that card is in journey" do
        expect(subject).to be_in_journey
      end

    end

    describe "#touch_out" do

      it "Test that card can be touched out" do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it "should test that minimum value is deducted from card at touch out" do
        subject.touch_out
        expect{ subject.touch_out }.to change{ subject.balance }.by(-described_class::MINIMUM_BALANCE)
      end

    end

end

end
