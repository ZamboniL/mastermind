# frozen_string_literal: true

# Player is the parent class for bot the breaker and maker
# The main functionality of player is to get or generate a number
# and guarantee that that number is constrained within the games
# rules
class Player
  attr_reader :type

  def initialize(type)
    @type = type # store the 'code' or 'guess' string depending on the player
  end

  # return a number from the person playing the game
  # them separates that into an array
  def ask_number
    gets.chomp.split('')
  end

  # Make the request to the player for a number, sees if the format is right
  # then returns that number, else it asks again until the number passes the check
  def create_number
    puts "Make your #{@type}, using four digits between 1-6; Ex: 1234"
    number = map_to_index(ask_number)
    check = validate_number(number)
    return number unless check

    puts check
    create_number
  end

  # Create a random number making console outputs and waiting some time so
  # the game doesn't go too fast
  def random_number
    puts "The Computer is choosing a new #{@type}\n\n"
    wait_time(7, 0.25)
    puts "The Computer #{@type} was selected ".pink
    puts
    Array.new(4) { rand(6) }
  end

  def map_to_index(index)
    index.map { |i| i.to_i - 1 }
  end

  private

  # The number validation according to the rules of the game
  # With some console outputs as error messages
  def validate_number(number)
    number_regex = "/\A[-+]?[0-9]*\.?[0-9]+\Z/"
    if number.length != 4
      "Your #{@type} should be 4 digits long".red
    elsif number.any? { |i| i =~ number_regex }
      "Your #{@type} should be compost of digits".red
    elsif number.any? { |i| i.to_i > 5 || i.to_i.negative? }
      "Your #{@type} digits should be between 1 and 6".red
    else
      false
    end
  end

  # Wait time method with a little terminal animation
  def wait_time(times, seconds)
    bar = ['.', '..', '...', '..']
    i = 0
    times.times do
      puts "\r \e[A \e[K#{bar[i % bar.length]}"
      sleep(seconds)
      i += 1
    end
  end
end
