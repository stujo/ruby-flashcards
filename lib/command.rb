module Flashcards
  class Command
    attr_reader :action, :params
    def initialize  action, params = {}
      @action = action
      @params = params
    end

    def self.commandize command_or_symbol
      if command_or_symbol.is_a? Symbol
        Command.new(command_or_symbol)
      else
        command_or_symbol
      end
    end

    def self.extract_command input, allowed=nil
      matches = /\.([a-z]+)(.*)/.match(input)
      if matches
        candidate = matches[1].to_sym
        if (allowed.nil? || allowed.include?(candidate))
          Command.new(candidate, {arg: matches[2]})
        else
          Command.new(:help, {unknown_command: input})
        end
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
