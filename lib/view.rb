module Flashcards
  class View
    GLOBAL_MENU = [:quit, :help, :no_logging, :logging, :debugging]
    CARD_MENU = [:skip] + GLOBAL_MENU
    WELCOME_MENU = GLOBAL_MENU
    HELP_MENU = GLOBAL_MENU

    def show_welcome game
      clear_screen
      puts "Welcome to Flashcards! - #{game.deck_name}"
      get_menu_option(Command.new(:continue), WELCOME_MENU)
    end

    def show_help arg = nil, unknown_command = nil, raw_input = nil
      clear_screen
      puts "Help!"
      puts "For #{arg}" if arg
      puts "Unknown Command #{unknown_command}" if unknown_command
      puts "Unknown Input #{raw_input}" if raw_input
      get_menu_option(Command.new(:default), HELP_MENU)
    end

    def show_current_card game
      clear_screen
      puts "Deck Name:  #{game.deck_name}"
      puts "Completed:  #{game.current_index}/#{game.total_cards} (#{game.total_solved} solved)"
      puts_separator
      puts "Definition: #{game.current_card.definition}"
      puts "Attempts:   #{game.current_card.attempt_count}"
      puts_separator
      parse_command_or_guess prompt("Your Answer (or .skip or .quit)", false)
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
    def puts_separator
      puts "-" * 80

    end

    def get_menu_option(default_command,
                        allowable_commands)
      input = prompt "Press <enter> for .#{default_command.action} (#{menu_option_string allowable_commands})"
      parse_command_or_default input, default_command, allowable_commands
    end

    def menu_option_string commands
      commands.map{ |command| "." + command.to_s }.join("|")
    end

    def prompt message, allow_empty = true
      begin
        print "#{message} : "
        input = gets.chomp
      end until allow_empty || !input.empty?
      input
    end

    def parse_command_or_default(input,
                                 default_command,
                                 allowable_commands)
      command = Command.extract_command input, allowable_commands
      if command.nil?
        default_command
      else
        command
      end
    end

    def parse_command_or_guess input
      command = Command.extract_command input, CARD_MENU
      if command.nil?
        Command.new(:guess, input: input)
      else
        command
      end
    end

    def clear_screen
      puts "\e[H\e[2J"
    end
  end
end
