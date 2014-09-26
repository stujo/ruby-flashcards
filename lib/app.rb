require 'pathname'
require_relative 'logger'
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
      @controller = Controller.new(@game)
      @view = View.new(@game)
    end

    def run
      puts "Flashcards"
      @controller.run_menu(@view)
    end
  end
end
