require_relative '../spec_helper'

describe 'CommandProcessor' do
  before do
    @command_processor = Processor::CommandProcessor.new
    @input_output_values = [
        ['hello world', 'Command not found or implemented'],
        ['create_parking_lot 6', 'Created parking lot with 6 slots'],
        ['create_parking_lot 6', 'Parking lot already exists'],
        ['status', "Slot No.\tRegistration No.\n"],
        ['park', "Registration Number is required"],
        ['park MH12-LJ-9893', "Allocated slot number: 1"],
        ['leave', "Registration Number is required"],
        ['leave MH12-LJ-9893', "Hours are required"],
        ['leave MH12-LJ-9893 2', "Registration number MH12-LJ-9893 with Slot Number 1 is free with Charge 10"],
        ['leave MH12-LJ-9893 2', "Registration number MH12-LJ-9893 not found"],
        ['park MH12-LJ-9893', "Allocated slot number: 1"],
        ['park MH12-LJ-9894', "Allocated slot number: 2"],
        ['park MH12-LJ-9895', "Allocated slot number: 3"],
        ['park MH12-LJ-9896', "Allocated slot number: 4"],
        ['park MH12-LJ-9897', "Allocated slot number: 5"],
        ['park MH12-LJ-9898', "Allocated slot number: 6"],
        ['park MH12-LJ-9899', "Sorry, parking lot is full"],
    ]
  end

  after do
    # Do nothing
  end

  context 'when various inputs are given to command processor' do
    it 'should return expected values' do
      @input_output_values.each { |pair|
        msg = @command_processor.process(pair[0])
        expect(msg).to eq(pair[1])
      }
    end
  end
end