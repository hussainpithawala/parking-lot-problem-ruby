require_relative 'base_command'

module Command
  class Leave < BaseCommand
    attr_reader :parking_lot, :reg_number, :hours

    def initialize(context)
      super(context)
      valid_arguments?
      @parking_lot = context.parking_lot
      @reg_number = context.reg_number
      @hours = context.hours
    end

    def execute
      slot = @parking_lot.get_slot_of_parked_vehicle(@reg_number)
      unless slot.nil?
        slot.vacate!
        charge = compute_charge
        "Registration number #{@reg_number} with Slot Number #{slot.index} is free with Charge #{charge}"
      else
        "Registration number #{@reg_number} not found"
      end
    end

    private

    def valid_arguments?
      context_is_not_nil?
      parking_lot_is_not_nil?
      valid_reg_number
      valid_hours
    end

    def valid_reg_number
      if context.reg_number.nil? or !context.reg_number.kind_of?(String)
        raise "Registration number should be present in the context"
      end
    end

    def valid_hours
      if context.hours.nil? or !context.hours.is_a?(Integer) or (context.hours < 1)
        raise "Hours should be present and greater than or equal to 1"
      end
    end

    def compute_charge
      remaining_hours = @hours - 2
      (remaining_hours + 1) * 10
    end
  end
end