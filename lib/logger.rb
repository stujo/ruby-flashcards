module Flashcards
  class Logger

    DEBUGGING_ENABLED = false
    LOGGING_ENABLED = false

    def self.log message, *args
      if LOGGING_ENABLED
        puts "LOG  :#{message}"
        p args unless args.nil? || args.empty?
      end
    end
    def self.debug message, *args
      if DEBUGGING_ENABLED
        puts "DEBUG:#{message}"
        p args unless args.nil? || args.empty?
      end
    end
  end
end
