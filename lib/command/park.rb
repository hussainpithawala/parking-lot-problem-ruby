require_relative 'base_command'

module Command
  class Park < BaseCommand
    PARKING_LOT_FULL = "Sorry, parking lot is full"
    attr_reader :parking_lot, :reg_number

    def initialize(context)
      super(context)
      valid_arguments?

      @parking_lot = context.parking_lot
      @reg_number = context.reg_number
    end

    def execute
      if parking_lot.is_full?
        PARKING_LOT_FULL
      else
        park_vehicle_in_slot
      end
    end

    private

    def park_vehicle_in_slot
      slot = parking_lot.get_vacant_slot
      unless slot.nil?
        slot.park!(Car.new(reg_number))
        "Allocated slot number: #{slot.index}"
      else
        PARKING_LOT_FULL
      end
    end

    def valid_arguments?
      context_is_not_nil?

      if context.parking_lot.nil?
        raise "Parking lot cannot be nil"
      end
    end

  end
end