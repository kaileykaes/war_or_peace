require 'spec_helper'

RSpec.describe Turn do
  before(:each) do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:diamond, 'Jack', 11) 
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12) 
    @card7 = Card.new(:heart, '3', 3)  
    @card8 = Card.new(:diamond, '2', 2)    
    @cards = [@card1, @card2, @card3]
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])   
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])   
    @player1 = Player.new("Megan", @deck1)    
    @player2 = Player.new("Aurora", @deck2)    
    @turn = Turn.new(@player1, @player2)
  end

  it 'exists' do
    expect(@turn).to be_a Turn
  end

  it 'has attributes' do 
    expect(@turn.player1).to eq(@player1)
    expect(@turn.player2).to eq(@player2)
  end

  it 'spoils_of_war method' do 
    expect(@turn.spoils_of_war).to eq([])
  end

  describe '#turn type' do 
    it 'turn type can be :basic'do
      expect(@turn.type).to eq(:basic)
    end

    it 'turn type can be war' do 
      @deck3 = Deck.new([@card1, @card2, @card5, @card8])
      @deck4 = Deck.new([@card6, @card4, @card6, @card7])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn2 = Turn.new(@player3, @player4)
      expect(@turn2.type).to eq(:war)
    end

    it 'turn type can be destruction' do 
      @deck3 = Deck.new([@card1, @card3, @card2, @card5])
      @deck4 = Deck.new([@card6, @card8, @card7, @card4])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn3 = Turn.new(@player3, @player4)
      expect(@turn3.type).to eq(:mutually_assured_destruction)
    end
  end

  describe '#winner' do 
    it 'has a winner for :basic turn type' do 
      expect(@turn.winner).to eq(@player2)
    end

    it 'winner for :war turn type' do 
      @deck3 = Deck.new([@card1, @card2, @card5, @card8])
      @deck4 = Deck.new([@card6, @card4, @card6, @card7])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn2 = Turn.new(@player3, @player4)
      expect(@turn2.type).to eq(:war)
      expect(@turn2.winner).to eq(@player4)
    end

    it 'winner for :mutually_assured_destruction turn type' do 
      @deck3 = Deck.new([@card1, @card3, @card2, @card5])
      @deck4 = Deck.new([@card6, @card8, @card7, @card4])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn3 = Turn.new(@player3, @player4)
      expect(@turn3.type).to eq(:mutually_assured_destruction)
      expect(@turn3.winner).to eq('No Winner')
    end
  end

  describe '#pile_cards' do 
    it 'piles cards for a :basic turn' do 
      @turn.pile_cards
      expect(@turn.type).to eq(:basic)
      expect(@turn.spoils_of_war).to eq([@card1, @card3])
    end

    it 'piles cards for a :war turn' do 
      @deck3 = Deck.new([@card1, @card2, @card5, @card8])
      @deck4 = Deck.new([@card6, @card4, @card6, @card7])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn2 = Turn.new(@player3, @player4)
      expect(@turn2.type).to eq(:war)
      @turn2.pile_cards
      expect(@turn2.spoils_of_war).to eq([@card1, @card2, @card5,@card6, @card4, @card6])
      expect(@player3.deck.cards).to eq([@card8])
      expect(@player4.deck.cards).to eq([@card7])
    end
    
    it 'does not pile cards for a :mutually_assured_destruction turn' do
      @deck3 = Deck.new([@card1, @card3, @card2, @card5])
      @deck4 = Deck.new([@card6, @card8, @card7, @card4])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn3 = Turn.new(@player3, @player4)
      expect(@turn3.type).to eq(:mutually_assured_destruction)
      @turn3.pile_cards
      expect(@turn3.spoils_of_war).to eq([])
      expect(@player3.deck.cards).to eq([@card5])
      expect(@player4.deck.cards).to eq([@card4])
    end
  end

  describe '#award_spoils' do
    it 'awards spoils in :basic turn' do 
      @turn.pile_cards
      @turn.award_spoils

      expect(@turn.winner).to eq(@player2)
      expect(@turn.spoils_of_war).to eq([@card1, @card3])
      expect(@player2.deck.cards).to eq([@card4, @card6, @card7, @card1, @card3])
      expect(@player1.deck.cards).to eq([@card2, @card5, @card8])
    end

    it 'awards spoils in :war turn' do 
      @deck3 = Deck.new([@card1, @card2, @card5, @card8])
      @deck4 = Deck.new([@card6, @card4, @card6, @card7])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn2 = Turn.new(@player3, @player4)
      @turn2.pile_cards
      @turn2.award_spoils
      expect(@turn2.spoils_of_war).to eq([@card1, @card2, @card5,@card6, @card4, @card6])
      expect(@player3.deck.cards).to eq([@card8])
      expect(@player4.deck.cards).to eq([@card7, @card1, @card2, @card5,@card6, @card4, @card6])
    end

    it 'awards spoils in :mutually_assured_destruction turn' do 
      @deck3 = Deck.new([@card1, @card3, @card2, @card5])
      @deck4 = Deck.new([@card6, @card8, @card7, @card4])
      @player3 = Player.new('Cameron', @deck3)
      @player4 = Player.new('Elise', @deck4)
      @turn3 = Turn.new(@player3, @player4)
      @turn3.pile_cards
      @turn3.award_spoils
      expect(@turn3.spoils_of_war).to eq([])
      expect(@player3.deck.cards).to eq([@card5])
      expect(@player4.deck.cards).to eq([@card4])
    end
  end
end