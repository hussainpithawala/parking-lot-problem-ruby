module Processor
  class CommandFactory
    def initialize
      @command_map = {
          :create_parking_lot => ->(params, old_context) {
            new_context = prepare_context_for_create(params, old_context)
            Command::Create.new(new_context)
          },
          :park => -> (params, old_context) {
            new_context = prepare_context_for_park(params, old_context)
            Command::Park.new(new_context)
          },
          :leave => -> (params, old_context) {
            new_context = prepare_context_for_leave(params, old_context)
            Command::Leave.new(new_context)
          },
          :status => -> (params, context) {
            Command::Status.new(context)
          }
      }
    end

    def make(command_key, params, context)
      function = @command_map[command_key]

      if function.nil?
        raise "Command not found or implemented"
      else
        function.call(params, context)
      end
    end

    private

    def prepare_context_for_create(params, context)
      unless context.nil?
        raise "Parking lot already exists"
      end
      capacity = params.first
      if capacity.nil?
        raise "Capacity is required to create a parking lot"
      end
      new_context = Context.new
      new_context.capacity = capacity.to_i

      new_context
    end

    def prepare_context_for_park(params, old_context)
      reg_number = params[0]

      if reg_number.nil?
        raise "Registration Number is required"
      end

      new_context = Context.new
      new_context.parking_lot = old_context.parking_lot
      new_context.reg_number = reg_number

      new_context
    end

    def prepare_context_for_leave(params, old_context)
      reg_number = params[0]

      if reg_number.nil?
        raise "Registration Number is required"
      end

      hours = params[1]
      if hours.nil?
        raise "Hours are required"
      end

      new_context = Context.new
      new_context.parking_lot = old_context.parking_lot
      new_context.reg_number = reg_number
      new_context.hours = hours.to_i

      new_context
    end
  end
end