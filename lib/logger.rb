module Flashcards
  module Logger

    def self.off
      @@log_level = LOG_LEVEL_NONE
    end

    def self.debugging
      @@log_level = LOG_LEVEL_DEBUG
    end

    def self.logging
      @@log_level = LOG_LEVEL_LOGGING
    end

    def self.log message, *args
      if @@log_level >= LOG_LEVEL_INFO
        puts "LOG  :#{message}"
        p args unless args.nil? || args.empty?
      end
    end

    def self.debug message, *args
      if @@log_level >= LOG_LEVEL_DEBUG
        puts "DEBUG:#{message}"
        p args unless args.nil? || args.empty?
      end
    end

    private
    LOG_LEVEL_NONE = 0
    LOG_LEVEL_INFO = 5
    LOG_LEVEL_DEBUG = 10

    @@log_level  = LOG_LEVEL_NONE
  end
end
