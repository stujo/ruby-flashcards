module Flashcards
  class Controller
    def initialize game, view
      @game = game
      @view = view
    end

    def start action = :welcome
      while next_action = dispatch_command(action)
        action = next_action
      end
      Logger.debug("run_menu exiting", action)
    end

    def dispatch_command action
      @previous_command = @command
      @command = Command.commandize action
      Logger.debug("Dispatching", @command)
      if respond_to?(@command.action_method)
        result = self.send(@command.action_method, @command.params)
      else
        result = action_help({unknown_command: action})
      end
      result.tap {|res| Logger.debug("dispatch_command #{@command.action} -> #{res}")}
    end

    def action_welcome params
      @view.show_welcome @game
    end

    def action_card params
      @view.show_current_card @game
    end

    def action_skip params
      :continue
    end

    def action_continue params
      if @game.has_more_cards
        @game.next_card
        :card
      else
        :done
      end
    end

    def action_default params
      if @game.current_card.solved?
        :continue
      else
        :card
      end
    end

    def action_help params
      @view.show_help params[:arg], params[:unknown_command], params[:raw]
    end

    def action_guess params
      if @game.current_card.try_answer params[:input]
        :continue
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

    def go_back_command
      target = :help
      if @previous_command
        target, @previous_command = @previous_command, nil
      end
      target
    end

    def action_debugging params
      Logger.debugging
      go_back_command
    end

    def action_logging params
      Logger.logging
      go_back_command
    end

    def action_no_logging params
      Logger.off
      go_back_command
    end
  end
end
