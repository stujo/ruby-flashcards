require 'pathname'
require 'pry'
require_relative 'exception'
require_relative 'logger'
require_relative 'command'
require_relative 'card'
require_relative 'game'
require_relative 'view'
require_relative 'controller'

module Flashcards

  APP_ROOT = Pathname.new(__FILE__).dirname
  CARD_FOLDER = APP_ROOT.parent.join('cards')

  class App

    def initialize
      @game  = Game.new('animals.deck')
      @controller = Controller.new(@game, View.new)
    end

    def run
      @controller.run_menu
    end
  end
end
