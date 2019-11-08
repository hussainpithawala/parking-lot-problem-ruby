module Command
  class BaseCommand
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def context_is_not_nil?
      if context.nil?
        raise "Uninitialized context.. cannot proceed ahead"
      end
    end

    def parking_lot_is_not_nil?
      if context.parking_lot.nil?
        raise "Parking lot cannot be nil"
      end
    end

    def execute
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end