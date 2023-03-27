require 'spec_helper'

RSpec.describe CardGenerator do
  before(:each) do
    @file = './data/cards.txt'
    @cards = CardGenerator.new(@file).make_cards
  end

  it '#make_cards' do
    expect(@cards).to all(be_an_instance_of(Card))
  end
end