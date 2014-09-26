module Flashcards
  class Deck
    def initialize  deck_file
      full_deck_file = CARD_FOLDER.join(deck_file)
      Logger.debug "Loading deck", full_deck_file
    end
  end
end
