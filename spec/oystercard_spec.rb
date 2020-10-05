# in spec/oystercard_spec.rb
require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
  end

  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect { subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.top_up(2)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.top_up(2)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject).not_to be_in_journey
  end

  it 'will not touch in if below minimum balance' do
    expect { subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
  end

  it 'deducts balance when you touch_out' do
    subject.top_up(2)
    subject.touch_in(station)
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a journey' do
    subject.top_up(2)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end
end