class CardGenerator
  attr_reader :cards
  
  def initialize(cards)
    @cards = cards
  end

  def make_cards 
    y = File.readlines(@cards)
    y.each_with_object([]) do |card, box|
      c = card.chomp.split(',')
      box << Card.new(c[1].strip.downcase.to_sym, c[0].strip, c[2].strip.to_i)
    end
  end
end