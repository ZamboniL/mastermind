# frozen_string_literal: true

require_relative 'colors'
require_relative 'peg'
require_relative 'display'
require_relative 'board'
require_relative 'players/player'
require_relative 'players/maker'
require_relative 'players/breaker'

# All the code that is necessary to start the game
game = Display.new
game.start_game
