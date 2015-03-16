class Hand
  def initialize(hand)
    @cards = hand.map { |card| Card.new(card[0], card[1]) }
  end

  def score
    strategy_chain = ThreeOfAKindStrategy.new(PairStrategy.new(HighCardStrategy.new))
    strategy_chain.chain_score(@cards)
  end
end

class BaseStrategy
  attr_accessor :next

  def initialize(next_strategy=nil)
    @next = next_strategy
  end

  def chain_score(cards)
    score(cards) || @next.chain_score(cards)
  end

  def score(cards)
    raise NotImplementedError, "#{self.class} needs to implement score"
  end
end

class HighCardStrategy < BaseStrategy
  def score(cards)
    high_card = cards.sort.last
    Score.new(Score::HIGH_CARD, high_card.number)
  end
end

class NOfAKindStrategy < BaseStrategy
  def find_n_of_a_kind(n, cards)
    counts = Hash.new(0)

    cards.each do |card|
      counts[card.number] += 1
    end

    counts.invert[n]
  end
end

class PairStrategy < NOfAKindStrategy
  def score(cards)
    pair = find_n_of_a_kind(2, cards)
    Score.new(Score::PAIR, pair) if pair
  end
end

class ThreeOfAKindStrategy < NOfAKindStrategy
  def score(cards)
    triple = find_n_of_a_kind(3, cards)
    Score.new(Score::THREE_OF_A_KIND, triple) if triple
  end
end

class Card
  attr_accessor :number, :suit

  VALUES = {'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}

  def initialize(number, suit)
    @number = VALUES[number] || number.to_i
    @suit = suit
  end

  def <=>(card)
    number.<=>(card.number)
  end

end

class Score < Struct.new(:score_type, :score_value)
  HIGH_CARD = 1
  PAIR = 2
  THREE_OF_A_KIND = 3
end