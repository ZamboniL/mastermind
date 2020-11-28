# frozen_string_literal: true

require_relative 'colors'

# The main game piece
class Peg
  # 6 piece options
  def color(number)
    return '  1  '.blue if number.zero?

    return '  2  '.red if number == 1

    return '  3  '.green if number == 2

    return '  4  '.yellow if number == 3

    return '  5  '.pink if number == 4

    '  6  '.light_blue
  end
end
