require 'spec_helper.rb'

def assigns(name)
  subject.instance_variable_get("@#{name}")
end

describe Life do
  subject(:life) { Life.new(3, 3) }

  it 'should start empty' do
    expect(life.display).to eq(
                                ". . .\n" +
                                ". . .\n" +
                                ". . .\n")
  end

  it 'should display living cells' do
    life.cells[0].live!
    life.cells[4].live!
    expect(life.display).to eq("* . .\n. * .\n")
  end

  describe '#calculate_column' do
    it 'should calculate the column of a given index value' do
      expect(life.calculate_column(0)).to eq 1
      expect(life.calculate_column(1)).to eq 2
      expect(life.calculate_column(2)).to eq 3
      expect(life.calculate_column(3)).to eq 1
      expect(life.calculate_column(4)).to eq 2
    end
  end

  describe '#calculate_row' do
    it 'should calculate the column of a given index value' do
      expect(life.calculate_row(0)).to eq 1
      expect(life.calculate_row(1)).to eq 1
      expect(life.calculate_row(2)).to eq 1
      expect(life.calculate_row(3)).to eq 2
    end
  end

  describe '#seed_living_cell' do
    it 'should set cell to be alive' do
      life.seed_living_cell(1,1)
      expect(life.display).to eq("* . .\n. . .\n")
    end

  end

  describe '#process_generation' do
    it 'should send a message to the bus signaling that the generation has ended' do
      expect(life.bus).to receive(:message).with(Life::GENERATION_MESSAGE)
      expect(life.bus).to receive(:send_messages)
      life.process_generation
    end

    it 'should process the first generation successfully' do
      life = Life.new(2,2)
      life.seed_living_cell(1,1)
      life.seed_living_cell(2,2)
      life.seed_living_cell(1,2)
      expect(life.display).to eq("* .\n* *\n")
      life.process_generation
      expect(life.display).to eq("* *\n* *\n")
    end
  end

end

describe Cell do

  let(:bus) { Bus.new }

  subject(:cell) { Cell.new(1, 1, bus, alive) }
  let(:alive) { false }

  describe 'on initialize' do

    it 'should register self with the bus' do
      bus = Bus.new
      expect { Cell.new(1, 2, bus) }.to change { bus.subscribers.length }.from(0).to(1)
    end

  end

  describe '#display' do
    context 'living cell' do
      let(:alive) { true }
      it 'should return a *' do
        expect(subject.display).to eq('*')
      end
    end
    context 'dead cell' do
      let(:alive) { false }
      it 'should return a .' do
        expect(subject.display).to eq('.')
      end
    end
  end

  describe '#process_message' do
    subject(:cell) { Cell.new(1, 1, bus, alive) }

    context 'birth message' do
      it 'should increase its neighbour count if a neighbour is born' do
        message = {event: :birth, location: [1,2]}
        expect{subject.process_message(message)}.to change{assigns(:neighbour_count)}.from(0).to(1)
      end
      it 'should not increase its neighbour count if a far away cell is born' do
        message = {event: :birth, location: [5,2]}
        expect{subject.process_message(message)}.to_not change{assigns(:neighbour_count)}
      end
    end

    context 'death message' do
      it 'should decrement its neighbour count if a neighbour dies' do
        subject.process_message({event: :birth, location: [2,2]})
        subject.process_message({event: :birth, location: [2,1]})
        message = {event: :death, location: [1,2]}
        expect{subject.process_message(message)}.to change{subject.instance_variable_get(:@neighbour_count)}.from(2).to(1)
      end
    end

    context 'generation message' do
      it 'should decide whether it lives or dies' do
        expect(subject).to receive(:set_new_status)
        subject.process_message({event: :generation})
      end
    end


  end

  describe '#set_new_status' do
    context 'when living' do
      let(:alive) { true }

      neighbour_count = [{count: 2},
                         {count: 3}]

      neighbour_count.each do |nc|
        it "should stay alive if neighbour count is #{nc[:count]}" do
          allow(subject).to receive(:neighbour_count).and_return(nc[:count])
          subject.set_new_status
          expect(subject.alive?).to eq(true)
        end
      end

      neighbour_count = [{count: 0},
                         {count: 1},
                         {count: 4},
                         {count: 5},
                         {count: 6},
                         {count: 7},
                         {count: 8}]

      neighbour_count.each do |nc|
        it "should die if neighbour count is #{nc[:count]}" do
          allow(subject).to receive(:neighbour_count).and_return(nc[:count])
          subject.set_new_status
          expect(subject.alive?).to eq(false)
        end
      end
    end

    context 'when dead' do
      let(:alive) { false}

      it 'should live if neighbour count is 3' do
        allow(subject).to receive(:neighbour_count).and_return(3)
        subject.set_new_status
        expect(subject.alive?).to eq(true)
      end

      it 'should stay dead with a neighbour count other than 3' do
        allow(subject).to receive(:neighbour_count).and_return(2)
        subject.set_new_status
        expect(subject.alive?).to eq(false)
      end

    end
  end

  describe '#is_neighbour?' do
    it 'should return true if a cell is a neighbour' do
      expect(subject.is_neighbour?(0, 0)).to be_truthy
      expect(subject.is_neighbour?(0, 1)).to be_truthy
      expect(subject.is_neighbour?(0, 2)).to be_truthy

      expect(subject.is_neighbour?(1, 0)).to be_truthy
      expect(subject.is_neighbour?(1, 2)).to be_truthy

      expect(subject.is_neighbour?(2, 0)).to be_truthy
      expect(subject.is_neighbour?(2, 1)).to be_truthy
      expect(subject.is_neighbour?(2, 2)).to be_truthy
    end

    it 'should return false if a cell is not a neighbour' do
      expect(subject.is_neighbour?(2, 6)).to be_falsey
      expect(subject.is_neighbour?(3, 1)).to be_falsey
    end

    it 'should return false if the cell is itself' do
      expect(subject.is_neighbour?(1, 1)).to be_falsey
    end
  end


  describe '#send_message' do
    it 'sends provided message to the bus' do
      message = {event: :test}
      expect(bus).to receive(:message).with(message)
      cell.send_message(message)
    end
  end

  describe '#alive?' do
    context 'living cell' do
      let(:alive) { true }

      it { is_expected.to be_alive }
    end

    context 'dead cell' do
      let(:alive) { false }

      it { is_expected.not_to be_alive }
    end
  end

  describe '#live!' do
    before do
      cell.live!
    end

    context 'dead cell' do
      let(:alive) { false }

      it { is_expected.to be_alive }
    end

    context 'living cell' do
      let(:alive) { true }

      it { is_expected.to be_alive }
    end

    it 'should emit a birth message' do
      expect(subject).to receive(:send_message).with(subject.birth_message)
      subject.live!
    end
  end

  describe '#die!' do
    before(:each) do
      cell.die!
    end
    context 'living cell' do
      let(:alive) { true }
      it { is_expected.to_not be_alive }
    end
    context 'dead cell' do
      it { is_expected.to_not be_alive }
    end
    it 'should emit a death message' do
      expect(subject).to receive(:send_message).with(subject.death_message)
      subject.die!
    end
  end

end

describe Bus do
  subject(:bus) { Bus.new() }

  describe '#message' do
    it 'should add a new message to the front of the queue' do
      bus.message('message1')
      bus.message('message2')
      expect(bus.messages).to eq(['message1', 'message2'])
    end

  end

  describe '#send_messages' do
    it 'should send messages to cells' do
      cell = Cell.new(1, 2, bus)
      message = {message: 'm1'}
      bus.messages = [message]
      expect(cell).to receive(:process_message).with(message)
      bus.send_messages
    end
  end

end