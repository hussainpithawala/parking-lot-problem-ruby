require 'spec_helper'

describe 'Status Command' do
  before do
    @context = Context.new
  end

  after do
    # Do nothing
  end

  context 'when context is unprepared' do
    it 'fails to create a command' do
      @context = nil
      expect { Command::Status.new(@context) }.to raise_error(RuntimeError, 'Uninitialized context.. cannot proceed ahead')
    end
  end

  context 'when parking lot is nil' do
    it 'fails to create a command' do
      expect { Command::Status.new(@context) }.to raise_error(RuntimeError, 'Parking lot cannot be nil')
    end
  end

  context 'context is prepared with a valid parking with all slots vacant' do
    it 'just returns header for the Slot and Registration' do
      @context.parking_lot = ParkingLot.new(1)
      status = Command::Status.new(@context)
      msg = status.execute
      expect(msg).to eq("Slot No.\tRegistration No.\n")
    end
  end

  context 'context is prepared with a valid parking with all slots full' do
    it 'should return header for the Slot and Registration and row values' do
      @context.parking_lot = ParkingLot.new(6)
      @context.parking_lot.slots.each {|slot| slot.park!(Car.new("MH-12-LJ-9893"))}
      park = Command::Park.new(@context)
      park.execute

      status = Command::Status.new(@context)
      msg = status.execute
      expect(msg).to eq("Slot No.\tRegistration No.\n1\t\tMH-12-LJ-9893\t\t\n2\t\tMH-12-LJ-9893\t\t\n3\t\tMH-12-LJ-9893\t\t\n4\t\tMH-12-LJ-9893\t\t\n5\t\tMH-12-LJ-9893\t\t\n6\t\tMH-12-LJ-9893\n")
    end
  end
end