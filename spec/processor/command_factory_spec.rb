require 'spec_helper'

describe 'Command Factory making different commands' do
  before do
    @context = Context.new
    @context.parking_lot = ParkingLot.new(6)
    @context.parking_lot.slots.each { |slot| slot.park!(Car.new("MH-12-LJ-9893")) }
    @command_factory = Processor::CommandFactory.new
  end

  after do
    # Do nothing
  end

  context 'when a command factory\'s make method is called' do
    it 'should raise errors if called with invalid or unimplemented command' do
      command_key = 'hello'
      params = ['world', 1]
      expect { @command_factory.make(command_key, params, @context) }.to raise_error(RuntimeError, 'Command not found or implemented')
    end

    it 'should return object for status command successfully' do
      command_key = :status
      status_command = @command_factory.make(command_key, [], @context)
      expect(status_command.nil?).to be_falsey
    end

    it 'should not return object for create_parking_lot command and raise an error' do
      expect {
        @context = nil
        command_key = :create_parking_lot
        @command_factory.make(command_key, [], @context)
      }.to raise_error(RuntimeError, "Capacity is required to create a parking lot")
    end

    it 'should return object for create_parking_lot command successfully' do
      @context = nil
      command_key = :create_parking_lot
      park_command = @command_factory.make(command_key, [6], @context)
      expect(park_command.nil?).to be_falsey
    end

    it 'should not return object for park command and raise an error' do
      expect {
        command_key = :park
        @command_factory.make(command_key, [], @context)
      }.to raise_error(RuntimeError, "Registration Number is required")
    end

    it 'should return object for park command successfully' do
      command_key = :park
      park_command = @command_factory.make(command_key, ["MH12-LJ-9893"], @context)
      expect(park_command.nil?).to be_falsey
    end

    it 'should not return object for leave command and raise an error' do
      expect {
        command_key = :leave
        @command_factory.make(command_key, [], @context)
      }.to raise_error(RuntimeError, "Registration Number is required")

      expect {
        command_key = :leave
        @command_factory.make(command_key, ["MH12-LJ-9893"], @context)
      }.to raise_error(RuntimeError, "Hours are required")
    end

    it 'should return object for leave command successfully' do
      command_key = :park
      park_command = @command_factory.make(command_key, ["MH12-LJ-9893", 6], @context)
      expect(park_command.nil?).to be_falsey
    end

    it 'succeeds and returns different commands' do
      expect(@command_factory.nil?).to be_falsey
    end
  end
end