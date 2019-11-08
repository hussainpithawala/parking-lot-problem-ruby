class ParkingLot
  attr_reader :capacity, :slots

  def initialize(capacity)
    @slots = []
    (1..capacity).to_a.each do |number|
      slots.push(Slot.new(number))
    end
  end

  def has_any_vacant_slot?
    !slots.nil? and slots.any? { |slot| slot.is_vacant? }
  end

  def is_full?
    !has_any_vacant_slot?
  end

  def get_vacant_slot
    slots.sort_by { |slot| slot.index }.detect { |slot| slot.is_vacant? }
  end

  def has_vehicle_with_reg_number(reg_number)
    slots.any? { |slot| !slot.is_vacant? and slot.parked_vehicle.reg_number == reg_number }
  end

  def get_slot_of_parked_vehicle(reg_number)
    slots.detect { |slot| !slot.is_vacant? and slot.parked_vehicle.reg_number == reg_number }
  end

end