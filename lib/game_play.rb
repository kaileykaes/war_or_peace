class GamePlay
  attr_reader :turns, 
              :player1, 
              :player2
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turns = []
  end
  
  def add_turn(turn)
    @turns << turn
  end

  def start
    turn = Turn.new(@player1, @player2)
    @turns << turn
  end

  def game_won?
    if @player1.deck.cards.empty? || @player2.deck.cards.empty?
      true
    else
      false 
    end
  end

  def win_it_all
    if @player1.deck.cards.empty?
      @player2
    elsif @player2.deck.cards.empty?
      @player1
    end
  end

  def play
    until @turns.length == 1000000
      if self.game_won? == true
        puts "*~*~*~* #{self.win_it_all.name} has won the game *~*~*~*" 
        break
      elsif self.game_won? == false && @turns.length == 1000000
        puts '---- DRAW ----'
        break
      else
        current_turn = @turns.last
        current_turn.pile_cards 
        current_turn.award_spoils
        @turns << current_turn
        if current_turn.type == :basic 
          puts "Turn #{@turns.length}: #{current_turn.winner.name} won #{current_turn.spoils_of_war.length}!"
        elsif current_turn.type == :war
          puts "Turn #{@turns.length}: WAR! #{current_turn.winner.name} won #{current_turn.spoils_of_war.length}!"
        elsif current_turn.type == :mutually_assured_destruction
          puts "Turn #{@turns.length}: *mutually assured destruction* 6 cards removed from play"
        end
      end 
    end

  end
end