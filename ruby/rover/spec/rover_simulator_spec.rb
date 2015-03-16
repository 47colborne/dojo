require 'spec_helper.rb'

describe RoverSimulator do
  describe '#plateau_setup' do
    it 'should save the given width and length' do
      subject.plateau_setup(5, 6)
      expect(subject.plateau_width).to eq(5)
      expect(subject.plateau_length).to eq(6)
    end
  end

  describe '#initial_rover_position' do
    it 'should save the given rover position' do
      subject.initial_rover_position(1, 2, 'N')
      expect(subject.rover.position).to eq(Position.new(1, 2, 'N'))
    end
  end
end

describe Rover do
  let(:position) { Position.new(1, 2, 'N') }

  it 'takes a command and alters it\'s position accordingly' do
    rover = Rover.new(position)
    command = double(:command)
    expect(command).to receive(:execute).with(position)
    rover.execute(command)
  end
end

describe Position do
  string_to_degree_table = [
      ['N', 0],
      ['E', 90],
      ['S', 180],
      ['W', 270]
  ]

  degree_to_string_table = [
      [0, 'N'],
      [90, 'E'],
      [180, 'S'],
      [270, 'W'],
      [-90, 'W'],
      [360, 'N']
  ]

  string_to_degree_table.each do |mapping|
    string = mapping[0]
    degree = mapping[1]
    it "should convert '#{string}' to #{degree} degree" do
      expect(Position.new(0, 0, string).degree).to eq(degree)
    end

  end

  describe '#degree=' do
    degree_to_string_table.each do |mapping|
      degree = mapping[0]
      string = mapping[1]
      it "should convert #{degree} degree to '#{string}'" do
        position = Position.new(1,1,"N")
        position.degree = degree
        expect(position.direction).to eq(string)
      end
    end
  end
end

describe TurnCommand do
  describe 'Turn left command' do
    it 'should move the position 90 degrees counter-clockwise from N to W' do
      command = TurnCommand.new('L')
      expect(command.execute(Position.new(1, 1, 'N'))).to eq(Position.new(1, 1, 'W'))
    end

    it 'should move the position 90 degrees counter-clockwise from W to S' do
      command = TurnCommand.new('L')
      expect(command.execute(Position.new(1, 1, 'W'))).to eq(Position.new(1, 1, 'S'))
    end
  end
end
