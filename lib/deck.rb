class Deck
  attr_reader :cards, 
              :half_deck1, 
              :half_deck2
  
  def initialize(cards)
    @cards = cards
    @half_deck1 = []
    @half_deck2 = []
  end

  def rank_of_card_at(position)
    @cards[position] != nil ? @cards[position].rank : 0
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

  def remove_card
    @cards.slice!(0)
  end

  def add_card(card)
    @cards << card
  end

  #helpers

  def shuffle
    @cards.shuffle!
  end
  
  def deal
   split = @cards.each_slice(@cards.length/2).to_a
   @half_deck1 << split.first
   @half_deck2 << split.last
   @half_deck1.flatten!
   @half_deck2.flatten!
  end
end