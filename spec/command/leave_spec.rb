require_relative '../spec_helper'

describe 'Leave Command' do
  before(:context) do
    @context = Context.new
  end

  after do
    # Do nothing
  end

  context 'when an existing current context is nil' do
    it 'leave car command will fail' do
      @context = nil
      expect { Command::Leave.new(@context) }.to raise_error(RuntimeError, 'Uninitialized context.. cannot proceed ahead')
    end
  end

  context 'when a parking lot is nil' do
    it 'leave car command will fail' do
      expect { Command::Leave.new(@context) }.to raise_error(RuntimeError, 'Parking lot cannot be nil')
    end
  end

  context 'when a parking lot is available but registration number is not provided' do
    it 'leave car command will fail' do
      expect {
        @context.parking_lot = ParkingLot.new(1)
        Command::Leave.new(@context)
      }.to raise_error(RuntimeError, 'Registration number should be present in the context')
    end
  end

  context 'when a parking lot is available but leaving hours are not provided' do
    it 'leave car command will fail' do
      expect {
        @context.parking_lot = ParkingLot.new(1)
        @context.reg_number = "MH12-LJ-9893"
        Command::Leave.new(@context)
      }.to raise_error(RuntimeError, 'Hours should be present and greater than or equal to 1')
    end
  end

  context 'when a parking lot is available but all slots are empty' do
    it 'leave car command will fail' do
      @context.parking_lot = ParkingLot.new(1)
      @context.reg_number = "MH12-LJ-9893"
      @context.hours = 2
      leave = Command::Leave.new(@context)
      msg = leave.execute
      expect(msg).to eq('Registration number MH12-LJ-9893 not found')
    end
  end

  context 'when a parking lot is available and a slot is filled with given registration number' do
    it 'leave car command will succeed' do
      reg_number = "MH12-LJ-9893"
      @context.parking_lot = ParkingLot.new(1)
      @context.parking_lot.slots.first.park!(Car.new(reg_number))
      @context.reg_number = reg_number
      @context.hours = 2
      leave = Command::Leave.new(@context)
      msg = leave.execute
      expect(msg).to eq('Registration number MH12-LJ-9893 with Slot Number 1 is free with Charge 10')
    end
  end
end