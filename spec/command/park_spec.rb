require 'spec_helper'

describe 'Park Command' do
  before(:context) do
    @context = Context.new
  end

  after do
    # Do nothing
  end

  context 'when an existing current context is nil' do
    it 'fails to park a car' do
      @context = nil
      expect { Command::Park.new(@context) }.to raise_error(RuntimeError, 'Uninitialized context.. cannot proceed ahead')
    end
  end

  context 'when a parking lot is nil' do
    it 'fails to park a car' do
      expect { Command::Park.new(@context) }.to raise_error(RuntimeError, 'Parking lot cannot be nil')
    end
  end

  context 'when a context with parking lot exists but no slots are available' do
    it 'fails to park a car' do
      @context.parking_lot = ParkingLot.new(1)
      @context.parking_lot.slots.each {|slot| slot.park!(Car.new("MH-12-LJ-9893"))}
      park = Command::Park.new(@context)
      msg = park.execute
      expect(msg).to eq(Command::Park::PARKING_LOT_FULL)
    end
  end

  context 'when a context with parking lot exists and slots are available' do
    it 'succeeds to park a car' do
      @context.parking_lot = ParkingLot.new(1)
      @context.parking_lot.slots.first {|slot| slot.park!(Car.new("MH-12-LJ-9893"))}
      park = Command::Park.new(@context)
      msg = park.execute
      expect(msg).to eq('Allocated slot number: 1')
    end
  end
end