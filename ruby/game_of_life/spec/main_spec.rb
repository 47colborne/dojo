require 'spec_helper.rb'

describe Grid do

  it 'should represent a lifeless grid' do
    grid = Grid.new(1, 1)
    expect(grid.to_s).to eq(".\n")
  end

  it 'should represent a large grid' do
    grid = Grid.new(2, 2)
    expect(grid.to_s).to eq("..\n..\n")
  end

  it 'should be able to place a living cell' do
    grid = Grid.new(1, 1)
    grid.set_cell(1, 1)
    expect(grid.to_s).to eq("*\n")
  end

  it 'should be able to place multiple cells' do
    grid = Grid.new(2, 2)
    grid.set_cell(1, 1)
    grid.set_cell(1, 2)
    grid.set_cell(2, 1)
    grid.set_cell(2, 2)
    expect(grid.to_s).to eq("**\n**\n")
  end
end
