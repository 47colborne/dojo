require './lib/main'

puts 'Enter number of rows: '
rows = gets.to_i
puts 'Enter number of columns: '
cols = gets.to_i
puts 'Enter the number of mines: '
num_mines = gets.to_i

minefield = Minefield.new(RandomPlacementStrategy.new, rows, cols)
minefield.lay_mines(num_mines)

loop do
  puts "\n#{minefield}\n\n"
  puts 'Enter a location to guess(row, col): '
  guess = gets.gsub(' ', '').split(',').map { |num| num.to_i - 1 }
  minefield.guess(*guess)
end