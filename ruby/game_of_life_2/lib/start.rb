require_relative './main.rb'

CELLS = [
    [10, 10],
    [11, 10],
    [10, 11],
    [10, 9],
    [11, 11],
    [11, 13],
    [13, 16],
    [12, 8],
    [10, 15],
    [11, 17]
]

CELLS2 = (1..80).to_a.product([25])

def start_game
  life = Life.new(80, 50)

  CELLS2.each do |cell|
    life.seed_living_cell(cell[0], cell[1])
  end

  life.start
end

start_game