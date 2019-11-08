class Slot
  attr_reader :index, :parked_vehicle

  def initialize(index)
    @index = index
    @parked_vehicle = nil
  end

  def is_vacant?
    parked_vehicle.nil?
  end

  def vacate!
    @parked_vehicle = nil
  end

  def park!(vehicle)
    @parked_vehicle = vehicle
  end

  def is_vehicle_parked(reg_number)
    if is_vacant?
      false
    else
      @parked_vehicle.reg_number <=> reg_number
    end
  end
end