require 'journey.rb'

describe Journey do


  let(:exit_station) { double :station }
  let(:entry_station) { double :station }

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

  it "should have penalty fare by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.end(exit_station)).to eq subject
  end

  context 'when given an entry station' do

    subject(:journey) { described_class.new(entry_station) }

    it 'has an entry station' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'when given an exit station' do

      before do
        subject.end(exit_station)
      end

      it 'calculates the fare' do
        expect(subject.fare).to eq 1
      end

      it 'knows if a journey is complete' do
        expect(subject).to be_complete
      end

    end

  end

end
