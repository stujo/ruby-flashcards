module Flashcards
  class Card
    attr_reader :definition, :answer
    def self.read(line)
      bits = line.chomp.split(":")
      Logger.debug "Reading", bits

      if bits.length == 2
        Card.new bits[0],bits[1]
      else
        Logger.log "Unable to create card", line, bits
        nil
      end
    end

    def try_answer possible_answer
      Logger.log("Possible '#{possible_answer}' '#{@answer}'")
      @attempts << possible_answer
      (@answer == possible_answer).tap{|x| @solved ||= x }
    end

    def attempt_count
      @attempts.length
    end  

    def solved?
      @solved
    end  

    private
    def initialize definition, answer
      @definition = definition
      @answer = answer
      @attempts = []
      @solved = false
    end
  end
end
