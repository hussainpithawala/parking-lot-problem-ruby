require 'spec_helper'

describe 'Create Command' do
  before do
    @context = Context.new
  end

  after do
    # Do nothing
  end

  context 'when context is unprepared' do
    it 'fails to create a command' do
      @context = nil
      expect { Command::Create.new(@context) }.to raise_error(RuntimeError, 'Uninitialized context.. cannot proceed ahead')
    end
  end

  context 'when context is prepared but capacity is negative' do
    it 'fails to create a command' do
      @context = Context.new
      @context.capacity = 0
      expect { Command::Create.new(@context) }.to raise_error(RuntimeError, 'capacity cannot be less than 1')
    end
  end

  context 'when context is prepared and capacity is passed as a parameter' do
    it 'succeeds to create a command' do
      @context.capacity = 6
      create = Command::Create.new(@context)
      msg = create.execute
      expect(msg).to eq("Created parking lot with 6 slots")
    end
  end
end