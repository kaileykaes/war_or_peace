require 'spec_helper'

RSpec.describe Deck do
  before(:each) do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
  end

#Iteration 1
  it 'exists' do
    expect(@deck).to be_a Deck
  end

  it 'has attributes' do 
    expect(@deck.cards).to eq([@card1, @card2, @card3])
  end

  it '#rank_of_card_at' do
    expect(@deck.rank_of_card_at(0)).to eq(12)
    expect(@deck.rank_of_card_at(2)).to eq(14)
  end

  it '#high_ranking_cards' do 
    expect(@deck.high_ranking_cards).to eq([@card1, @card3])
  end

  it '#percent_high_ranking' do
    expect(@deck.percent_high_ranking).to eq(66.67)
  end

  it '#remove_card & deck make-up changes' do
    expect(@deck.remove_card).to eq(@card1)
    expect(@deck.cards).to eq([@card2, @card3])
    expect(@deck.high_ranking_cards).to eq([@card3])
    expect(@deck.percent_high_ranking).to eq(50.0)
  end

  it 'adds cards and deck make-up changes' do 
    @deck.remove_card
    @card4 = Card.new(:club, '5', 5)
    @deck.add_card(@card4)
    expect(@deck.cards).to eq([@card2, @card3, @card4]) 
    expect(@deck.high_ranking_cards).to eq([@card3])
    expect(@deck.percent_high_ranking).to eq(33.33)
  end

  #helpers
  it '#shuffle' do 
    @card4 = Card.new(:club, '5', 5)
    @deck.add_card(@card4)
    expect(@deck.shuffle).to include(@card1, @card2, @card3, @card4)
    expect(@deck.shuffle).not_to eq(@deck)
  end

  it '#half_deck' do 
    @card4 = Card.new(:club, '5', 5)
    @deck.add_card(@card4)

    expect(@deck.half_deck1).to eq([])
    expect(@deck.half_deck2).to eq([])
    
    @deck.deal
    expect(@deck.half_deck1).to eq([@card1, @card2])
    expect(@deck.half_deck2).to eq([@card3, @card4])
  end

  it '#deal' do 
    @card4 = Card.new(:club, '5', 5)
    @deck.add_card(@card4)
    @deck.deal
    expect(@deck.half_deck1).to eq(@deck.cards[0..1])
    expect(@deck.half_deck2).to eq(@deck.cards[2..3])
  end
end