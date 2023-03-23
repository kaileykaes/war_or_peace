class Turn
  attr_reader :player1, 
              :player2, 
              :spoils_of_war
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end  

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      :basic 
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      :war 
    end
  end

  def winner
    if type == :basic
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0) 
        @player1
      else
        @player2
      end
    elsif type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2) 
        @player1
      else
        @player2
      end
    else
      'No Winner' 
    end
  end

  def pile_cards
    @spoils_of_war.clear
    if type == :basic
      @spoils_of_war << @player1.deck.cards[0] 
      @spoils_of_war << @player2.deck.cards[0]
      @player1.deck.remove_card 
      @player2.deck.remove_card
    elsif type == :war
      @spoils_of_war << @player1.deck.cards[0..2]
      @spoils_of_war << @player2.deck.cards[0..2]
      @spoils_of_war.flatten!
      3.times do 
        @player1.deck.remove_card 
      end
      3.times do
         @player2.deck.remove_card 
      end
    else
      3.times do 
        @player1.deck.remove_card 
      end
      3.times do
          @player2.deck.remove_card 
      end
    end
  end

  def award_spoils 
    winner.deck.cards << @spoils_of_war unless winner == 'No Winner'
    winner.deck.cards.flatten! unless winner == 'No Winner'
    winner if @spoils_of_war.length == 0
  end
end