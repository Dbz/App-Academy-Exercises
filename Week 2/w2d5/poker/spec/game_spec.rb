require 'rspec'
require './lib/game.rb'
require './lib/player.rb'
require './lib/deck.rb'

describe "game" do
  let(:game) { Game.new }
  it "holds the deck" do
    expect(game.deck).to eq(Deck.new)
  end
end