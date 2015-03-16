require 'spec_helper.rb'

describe Rover do
  let(:rover) { Rover.new(5, 5, 'E') }

  context 'initialization' do
    it 'initializes with a starting point' do
      expect(rover.x).to eq(5)
      expect(rover.y).to eq(5)
      expect(rover.direction).to eq('E')
    end
  end


  context 'upon turning' do
    turn_tests = [
        ['E', 'L', 'N'], ['E', 'R', 'S'],
        ['S', 'L', 'E'], ['S', 'R', 'W'],
        ['W', 'L', 'S'], ['W', 'R', 'N'],
        ['N', 'L', 'W'], ['N', 'R', 'E']
    ]

    turn_tests.each do |test|
      it "#{test[1]}, starting facing #{test[0]}, resulting direction #{test[2]}" do
        rover.direction = test[0]
        rover.process(test[1])
        expect(rover.direction).to eq(test[2])
      end
    end
  end

  context 'upon moving' do
    move_tests = [
        {direction: 'E', x: 6, y: 5},
        {direction: 'N', x: 5, y: 6},
        {direction: 'S', x: 5, y: 4},
        {direction: 'W', x: 4, y: 5}
    ]

    move_tests.each do |test|
      it "Facing #{test[:direction]}, moving to position x #{test[:x]} and position y #{test[:y]}}" do
        rover.direction = test[:direction]
        rover.process('M')
        expect(rover.x).to eq test[:x]
        expect(rover.y).to eq test[:y]
      end
    end

  end

end
