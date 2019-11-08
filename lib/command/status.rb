require_relative 'base_command'

module Command
  class Status < BaseCommand
    attr_reader :parking_lot, :msg

    def initialize(context)
      super(context)
      context_is_not_nil?
      parking_lot_is_not_nil?
      @parking_lot = context.parking_lot
    end

    def execute
      msg = ""
      msg << "Slot No.\tRegistration No.\n"
      sorted_slots = parking_lot.slots.sort_by { |slot| slot.index }

      last_slot = sorted_slots.pop

      sorted_slots.each do |slot|
        unless slot.is_vacant?
          msg << "#{slot.index}\t\t#{slot.parked_vehicle.reg_number}\t\t\n"
        end
      end

      unless last_slot.nil?
        unless last_slot.is_vacant?
          msg << "#{last_slot.index}\t\t#{last_slot.parked_vehicle.reg_number}\n"
        end
      end

      msg
    end
  end
end