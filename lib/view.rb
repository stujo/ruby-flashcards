module Flashcards
  class View
    def show_welcome game
      clear_screen
      puts "Welcome to Flashcards! - #{game.deck_name}"
      input = prompt "Press <enter> to continue (or .quit)"
      command_or_quit input, :next
    end

    def show_help params
      clear_screen
      puts "Help!"
      puts "Unknown Command #{params[:missing_action]}" if params[:missing_action]
      puts "Unknown Input #{params[:raw]}" if params[:raw]
      input = prompt "Press <enter> to continue (or .quit)"
      command_or_quit input, :default
    end

    def show_current_card game
      clear_screen
      puts "Deck Name:  #{game.deck_name}"
      puts "Completed:  #{game.current_index}/#{game.total_cards} (#{game.total_solved} solved)"
      puts "-" * 80
      puts "Definition: #{game.current_card.definition}"
      puts "Attempts:   #{game.current_card.attempt_count}"
      puts "-" * 80
      command_or_guess prompt("Your Answer (or .skip or .quit)", false)
    end

    def show_bye game
      clear_screen
      puts "Thank you for quitting!"
    end

    def show_report game
      clear_screen
      puts "Thank you for playing #{game.deck_name}!"
      puts "You solved #{game.total_solved} out of #{game.total_cards} cards"
      puts "You took #{game.total_attempts} attempts to solve #{game.total_solved} cards"
      puts
    end

    private

    def prompt message, allow_empty = true
      print "#{message} : "
      gets.chomp
    end

    def command_or_quit input, default_action, default_params={}
      command = Command.extract_command input, [:quit]
      command.nil? ? Command.new(default_action, default_params) : command
    end

    def command_or_guess input
      command = Command.extract_command input, [:quit, :skip]
      command.nil? ? Command.new(:guess, input: input) : command
    end

    def clear_screen
      puts "\e[H\e[2J"
    end
  end
end
