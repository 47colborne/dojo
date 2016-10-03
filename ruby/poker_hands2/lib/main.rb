class Game
  def self.score(player_1_hand, player_2_hand)
    player_1_highest = player_1_hand.max.number
    player_2_highest = player_2_hand.max.number

    player_1_highest > player_2_highest ? player_1_hand : player_2_hand
  end
end

class Card
  include Comparable

  attr_reader :number, :suit

  ORDER = %w(2 3 4 5 6 7 8 9 T J Q K A)

  def initialize(number, suit)
    @number = ORDER.index(number) + 2
    @suit = suit
  end

  def <=>(card)
    number <=> card.number
  end

  def inspect
    "#{@number}#{@suit}"
  end
end

class HighCardHand
  include Comparable

  attr_reader :cards

  def initialize(cards)
    @cards = cards.sort.reverse
  end

  def self.type_rank
    1
  end

  def <=>(other_hand)
    result = nil
    @cards.each_with_index do |card, index|
      result = card <=> other_hand.cards[index]
      return result unless result.zero?
    end
    result
  end
end
