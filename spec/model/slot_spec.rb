require_relative '../spec_helper'

describe 'Slot Behaviour' do
  before do
    @slot = Slot.new(1)
    @reg_number = "MH-12-LJ-9893"
  end

  after do
    # Do nothing
  end

  context 'over an empty slot' do
    it 'should return true when is_vacant? is invoked' do
      expect(@slot.is_vacant?).to be_truthy
    end
    it 'should return false when is_vehicle_parked is invoked' do
      expect(@slot.is_vehicle_parked(@reg_number)).to be_falsey
    end

    it 'should allow to park a vehicle' do
      @slot.park!(Car.new(@reg_number))
      expect(@slot.is_vacant?).to be_falsey
    end

    it 'should allow to vacate a vehicle' do
      @slot.park!(Car.new(@reg_number))
      expect(@slot.is_vacant?).to be_falsey
      expect(@slot.is_vehicle_parked(@reg_number)).to be_truthy
      @slot.vacate!
      expect(@slot.is_vacant?).to be_truthy
      expect(@slot.is_vehicle_parked(@reg_number)).to be_falsey
    end
  end
end