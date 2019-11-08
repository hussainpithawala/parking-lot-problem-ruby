require_relative '../spec_helper'

describe 'Parking Lot Behaviour' do
  before do
    @parking_lot = ParkingLot.new(5)
    @reg_number = "MH-12-LJ-9893"
  end

  after do
    # Do nothing
  end

  context 'when parking lot is empty' do
    it 'should have a vacant slot available' do
      expect(@parking_lot.has_any_vacant_slot?).to be_truthy
    end

    it 'should say parking lot is not full' do
      expect(@parking_lot.is_full?).to be_falsey
    end

    it 'should say that a vehicle is not present' do
      expect(@parking_lot.has_vehicle_with_reg_number(@reg_number)).to be_falsey
    end

    it 'should offer a vacant slot' do
      expect(@parking_lot.get_vacant_slot).not_to be_nil
    end

    it 'should return the vehicle\'s slot as nil' do
      expect(@parking_lot.get_slot_of_parked_vehicle(@reg_number)).to be_nil
    end
  end

  context 'when parking lot is full' do
    before do
      @parking_lot.slots.each { |slot| slot.park!(Car.new("MH-12-LJ-9893")) }
    end
    it 'should not have a vacant slot available' do
      expect(@parking_lot.has_any_vacant_slot?).to be_falsey
      expect(@parking_lot.get_vacant_slot).to be_nil
    end

    it 'should say parking lot is full' do
      expect(@parking_lot.is_full?).to be_truthy
    end

    it 'should return the slot of the parked vehicle' do
      expect(@parking_lot.get_slot_of_parked_vehicle(@reg_number)).not_to be_nil
    end
  end
end