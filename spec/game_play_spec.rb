require 'spec_helper'

RSpec.describe GamePlay do
  before(:each) do
    @card_1 = Card.new(:club, 'Ace', 14)
    @card_2 = Card.new(:club, '2', 2)
    @card_3 = Card.new(:club, '3', 3)
    @card_4 = Card.new(:club, '4', 4)
    @card_5 = Card.new(:club, '5', 5)
    @card_6 = Card.new(:club, '6', 6)
    @card_7 = Card.new(:club, '7', 7)
    @card_8 = Card.new(:club, '8',8)
    @card_9 = Card.new(:club, '9',9)
    @card_10 = Card.new(:club, '10',10)
    @card_11 = Card.new(:club, 'Jack',11)
    @card_12 = Card.new(:club, 'Queen',12)
    @card_13 = Card.new(:club, 'King',13)
    @card_14 = Card.new(:diamond, 'Ace', 14)
    @card_15 = Card.new(:diamond, '2', 2)
    @card_16 = Card.new(:diamond, '3', 3)
    @card_17 = Card.new(:diamond, '4', 4)
    @card_18 = Card.new(:diamond, '5', 5)
    @card_19 = Card.new(:diamond, '6', 6)
    @card_20 = Card.new(:diamond, '7', 7)
    @card_21 = Card.new(:diamond, '8', 8)
    @card_22 = Card.new(:diamond, '9', 9)
    @card_23 = Card.new(:diamond, '10', 10)
    @card_24 = Card.new(:diamond, 'Jack', 11)
    @card_25 = Card.new(:diamond, 'Queen', 12)
    @card_26 = Card.new(:diamond, 'King', 13)
    @card_27 = Card.new(:heart, 'Ace', 14)
    @card_28 = Card.new(:heart, '2', 2)
    @card_29 = Card.new(:heart, '3', 3)
    @card_30 = Card.new(:heart, '4', 4)
    @card_31 = Card.new(:heart, '5', 5)
    @card_32 = Card.new(:heart, '6', 6)
    @card_33 = Card.new(:heart, '7', 7)
    @card_34 = Card.new(:heart, '8', 8)
    @card_35 = Card.new(:heart, '9', 9)
    @card_36 = Card.new(:heart, '10', 10)
    @card_37 = Card.new(:heart, 'Jack', 11)
    @card_38 = Card.new(:heart, 'Queen', 12)
    @card_39 = Card.new(:heart, 'King', 13)
    @card_40 = Card.new(:spade, 'Ace', 14)
    @card_41 = Card.new(:spade, '2', 2)
    @card_42 = Card.new(:spade, '3', 3)
    @card_43 = Card.new(:spade, '4', 4)
    @card_44 = Card.new(:spade, '5', 5)
    @card_45 = Card.new(:spade, '6', 6)
    @card_46 = Card.new(:spade, '7', 7)
    @card_47 = Card.new(:spade, '8', 8)
    @card_48 = Card.new(:spade, '9', 9)
    @card_49 = Card.new(:spade, '10', 10)
    @card_50 = Card.new(:spade, 'Jack', 11)
    @card_51 = Card.new(:spade, 'Queen', 12)
    @card_52 = Card.new(:spade, 'King', 13)
    @cards = [
      @card_1, @card_2, @card_3, @card_4, @card_5, 
      @card_6, @card_7, @card_8, @card_9, @card_10, 
      @card_11, @card_12, @card_13, @card_14, @card_15, 
      @card_16, @card_17, @card_18, @card_19, @card_20, 
      @card_21, @card_22, @card_23, @card_24, @card_25, 
      @card_26, @card_27, @card_28, @card_29, @card_30,
      @card_31, @card_32, @card_33, @card_34, @card_35, 
      @card_36, @card_37, @card_38, @card_39, @card_40, 
      @card_41, @card_42, @card_43, @card_44, @card_45, 
      @card_46, @card_47, @card_48, @card_49, @card_50, 
      @card_51, @card_52
    ]
    @deck = Deck.new(@cards)
    @player1 = Player.new('Margot', @deck)
    @player2 = Player.new('Barney', @deck)
    @turn = Turn.new(@player1, @player2)
    @game = GamePlay.new
  end

  describe '#initialize' do 
    it 'exists' do
      expect(@game).to be_a GamePlay
    end

    it 'starts with empty array of turns' do 
      expect(@game.turns).to eq([])
    end

    it '#add_turn' do 
      @game.add_turn(@turn)
      expect(@game.turns).to eq([@turn])
    end
  end

  describe '#start' do 
    it 'creates a turn and adds it to turns array' do
    @game.start(@player1, @player2)
    expect(@game.turns).to include(Turn)
    end
  end

  describe '#game_won?'
    it 'returns true if a player has no cards' do 
      @player1.deck.cards.clear
      expect(@game.game_won?(@player1, @player2)).to be true
    end

    it 'returns false if a player has cards' do 
      expect(@game.game_won?(@player1, @player2)).to be false
    end
end