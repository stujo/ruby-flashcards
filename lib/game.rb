require_relative 'deck'

module Flashcards
  class Game
    def initialize deck_file
      @deck = Deck.new deck_file
    end
  end
end
