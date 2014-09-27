module Flashcards


  class Command
    attr_reader :action, :params
    def initialize  action, params = {}
      @action = action.to_sym
      @params = params
      Logger.debug("Command.new", @action, @params)
    end


    def self.commandize command_or_symbol
      if command_or_symbol.is_a? Symbol
        Command.new(command_or_symbol)
      else
        command_or_symbol
      end
    end

    def self.extract_command input, allowed=nil
      Logger.debug("self.extract_command", input, allowed)
      matches = /\.([a-z_]+)(.*)?/.match(input)
      if matches
        Logger.debug("matches", matches)
        lookup_command(matches[1].to_sym, matches[2], allowed)
      end
    end

    def self.lookup_command candidate, arg, allowed
      if (allowed.nil? || allowed.include?(candidate))
        Command.new(candidate, {arg: arg})
      else
        Command.new(:help, {unknown_command: candidate})
      end
    end

    def action_method
      "action_#{action}".to_sym()
    end

    def to_s
      "Command {#{action} with #{params}}"
    end

  end
end
