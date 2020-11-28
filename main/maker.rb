# frozen_string_literal: true

require_relative 'player'

# The Maker class, most of the methods are made by it's parent class
# but rewritess it so the console prompts are correct and to assign the
# code number to a class method
class Maker < Player
  attr_accessor :code

  def initialize
    super('code')
  end

  def random_number
    self.code = super
  end

  def create_number
    self.code = super
  end
end