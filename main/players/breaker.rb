# frozen_string_literal: true

require_relative 'player'

# The Breaker class, most of the methods are made by it's parent class
# but rewritess it so the console prompts are correct and to assign the
# guess number to a class method
class Breaker < Player
  attr_accessor :guess

  def initialize
    super('guess')
  end

  def random_number
    self.guess = super
  end

  def create_number
    self.guess = super
  end
end
