module Flashcards
  class Game

    attr_reader :current_index, :deck_name

    def initialize deck_file
      @deck_name = deck_file
      load_cards deck_file
      @deck.shuffle!
      @current_index = -1
    end

    def load_cards deck_file
      @deck = []
      full_deck_file = CARD_FOLDER.join(deck_file)
      Logger.debug "Loading deck", full_deck_file
      if File.exist? full_deck_file
        File.readlines(full_deck_file).each do |line|
          Logger.log("#{line}")
          card = Card.read(line)
          if card
            @deck << card
          end
        end
      else
        Logger.log("File #{full_deck_file} does not exist")
      end
    end

    def has_more_cards
      @current_index < @deck.length - 1
    end

    def current_card
      @deck[@current_index]
    end

    def next_card
      if has_more_cards
        @current_index+= 1
        current_card
      else
        raise Flashcards::FlashcardsException,
          "next_card called when has_more_cards is false"
      end
    end

    def total_solved
      @deck.reduce(0) do |memo, card|
        memo += 1 if card.solved?
        memo
      end
    end

    def total_attempts
      @deck.reduce(0) do |memo, card|
        memo + card.attempt_count
      end
    end

    def total_cards
      @deck.length
    end

    def card_complete
      current_card.solved?
    end

    def attempt_card guess
      current_card.try_answer guess
    end
  end
end
