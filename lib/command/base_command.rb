module Command
  class BaseCommand
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def execute
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end