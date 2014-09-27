module Flashcards
  class Controller
    def initialize game, view
      @game = game
      @view = view
    end

    def run_menu action = :welcome
      while action = dispatch_command(action)
      end
    end

    def dispatch_command action
      @command = Command.commandize action
      Logger.log("Dispatching", @command)
      if respond_to?(@command.action_method)
        result = self.send(@command.action_method, @command.params)
      else
        result = action_help({unknown_command: action})
      end
      result.tap{|res| Logger.log("dispatch_command #{@command.action} -> #{res}")}
    end

    def action_welcome params
      @view.show_welcome @game
    end

    def action_card params
      @view.show_current_card @game
    end

    def action_skip params
      :next
    end

    def action_next params
      if @game.has_more_cards
        @game.next_card
        :card
      else
        :done
      end
    end

    def action_default params
      if @game.current_card.solved?
        :next
      else
        :card
      end
    end

    def action_help params
      @view.show_help params
      :default
    end

    def action_guess params
      if @game.current_card.try_answer params[:input]
        :next
      else
        :card
      end
    end

    def action_quit params
      @view.show_bye @game
      false
    end

    def action_done params
      @view.show_report @game
      false
    end

  end
end
