# frozen_string_literal: true

require_relative 'peg'
require_relative 'players/player'
require_relative 'players/maker'
require_relative 'players/breaker'

# It's an aggregator for all the information about the game, doesn't do much
# alone but it creates everything the game needs and nests the other important
# classes
class Board
  attr_accessor :maker, :breaker, :matches, :correct_matches

  # At initialize create all the pegs, and the player child classes
  def initialize
    peg = Peg.new
    @pegs = Array.new(6) { |i| peg.color(i) }
    @breaker = Breaker.new
    @maker = Maker.new
  end

  # Output a string containing all the peg squares
  def show_total_pegs
    "#{@pegs[0]} #{@pegs[1]} #{@pegs[2]} #{@pegs[3]} #{@pegs[4]} #{@pegs[5]}"
  end

  # Output the code or guess pegs depending on what has been passed
  def format(maker_breaker)
    index = breaker.guess
    index = maker.code if maker_breaker.type == 'code'
    "#{@pegs[index[0]]} #{@pegs[index[1]]} #{@pegs[index[2]]} #{@pegs[index[3]]}"
  end

  # Update the total match count each round
  def update_total_matches
    self.correct_matches = (maker.code.filter.with_index { |v, i| v == breaker.guess[i] }).length
    self.matches = 4 - (maker.code - breaker.guess).length - correct_matches
  end
end
