module Processor
  class CommandProcessor
    attr_reader :valid_commands, :command_factory, :context

    def initialize
      @context = nil
      @command_factory = CommandFactory.new
    end

    def process(line)
      begin
        words = line.split(" ")
        command_key, params = words[0].to_sym, words[1..]
        command = command_factory.make(command_key, params, @context)
        msg = command.execute
        @context = command.context
        msg
      rescue ArgumentError, RuntimeError => error
        error.message
      end
    end
  end
end