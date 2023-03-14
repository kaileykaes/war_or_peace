class Deck
  attr_reader :cards
  
  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(position)
    @cards[position].rank
  end

  def high_ranking_cards
    big_cards = []
    @cards.each do |card|
      big_cards << card if card.rank >= 10
    end
    big_cards
  end

  def percent_high_ranking 
    ((high_ranking_cards.length * 100).to_f / @cards.length).round(2)
  end
end