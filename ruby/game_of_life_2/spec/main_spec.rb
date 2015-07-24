require 'spec_helper.rb'

describe Life do
  subject(:life) { Life.new(3, 2) }

  it 'should start empty' do
    expect(life.display).to eq(". . .\n. . .\n")
  end

  describe '#add_cell' do
    it 'should add a living cell' do
      life.add_cell(1, 2)
      expect(life.display).to eq(". . .\n* . .\n")
    end

    it 'should add a cell to every space' do
      3.times do |column|
        2.times do |row|
          life.add_cell(column + 1, row + 1)
        end
      end

      expect(life.display).to eq("* * *\n* * *\n")
    end

    it 'should create a new Cell' do
      life.add_cell(1, 2)
      expect(life.cells.length).to eq(1)
    end

    it 'should be registered with the bus' do
      life.add_cell(1, 2)
      expect(life.bus.cells.length).to eq(1)
    end

  end

end

describe Cell do

  let(:bus) {Bus.new}

  subject(:cell) { Cell.new(1, 1, bus) }

  describe 'on initialize' do

    it 'should register self with the bus' do
      bus = Bus.new
      expect { Cell.new(1, 2, bus) }.to change { bus.cells.length }.from(0).to(1)
    end

  end

  describe '#send_message' do
    it 'sends provided message to the bus' do
      message = {event: :test}
      expect(bus).to receive(:receive_message).with(message)
      cell.send_message(message)
    end
  end
end

describe Bus do
  subject(:bus) { Bus.new() }

  describe '#receive_message' do
    it 'should add a new message to the front of the queue' do
      bus.receive_message("message1")
      bus.receive_message("message2")
      expect(bus.messages).to eq(["message1", "message2"])
    end

  end

  describe '#send_messages' do
    it 'should send messages to cells' do
      cell = Cell.new(1, 2, bus)
      message = {message: "m1"}
      bus.messages = [message]
      expect(cell).to receive(:process).with(message)
      bus.send_messages
    end

  end

end