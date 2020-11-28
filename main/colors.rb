# frozen_string_literal: true

require_relative 'peg'

# Add color methods for the string class
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(41)
  end

  def green
    colorize(42)
  end

  def yellow
    colorize(43)
  end

  def blue
    colorize(44)
  end

  def pink
    colorize(45)
  end

  def light_blue
    colorize(46)
  end
end
