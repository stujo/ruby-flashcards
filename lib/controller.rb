module Flashcards
  class Controller
    def initialize game
      @game = game
    end

    def run_menu view
      input = view.get_input
      while(dispatch input)
      end
    end

    def dispatch input
      Logger.debug("Dispatching input #{input}")

      action = "action_#{input}".to_sym()
      if respond_to?(action)
        self.send(action)
      else
        Logger.log("Unknown action #{input}")
        false
      end
    end

    def action_quit
      false
    end

    def action_flash
      false
    end

  end
end
