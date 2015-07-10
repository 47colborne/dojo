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

end