# frozen_string_literal: true

require_relative 'board'

# Display class is responsible for the majority of the game flow
# writing prompts at the start of the game, it's methods control
# the rounds and checks for if the game is over
class Display
  attr_reader :player_guess
  attr_accessor :round

  # at initialize it creates the game board and round count
  def initialize
    @board = Board.new
    @round = 0
  end

  # start the game by printing the instructions and asking which side the player will be
  def start_game
    game_logo
    game_start_screen
    game_rules
    last_rules
    choice = maker_breaker
    game_maker if choice == 'm'
    game_breaker if choice == 'b'
  end

  # the breaker round, if the person playing chooses maker
  # the rounds will be automatic, else it asks the player
  # for input every round
  def breaker_rounds(who)
    while @round < 11
      @board.update_total_matches
      return win_screen if win? # check for if the breaker got everything right

      round_result
      @board.breaker.create_number if who == 'player'
      @board.breaker.random_number if who == 'computer'
    end
    @board.update_total_matches
    return win_screen if win? # check for if the breaker got everything right

    announce_code
  end

  # Print the result of the current round
  def round_result
    @round += 1
    puts "Round #{format('%02d', @round)}: #{@board.format(@board.breaker)}
You got #{@board.matches} matches and #{@board.correct_matches} correct guesses"
    puts 'Careful, the next one is your last chance!'.red if @round == 11
  end

  private

  def game_logo
    puts '
    ___  ___  ___   _____ _____ ______________  ________ _   _______
    |  \\/  | / _ \\ /  ___|_   _|  ___| ___ \\  \\/  |_   _| \\ | |  _  \\
    | .  . |/ /_\\ \\\\ `--.  | | | |__ | |_/ / .  . | | | |  \\| | | | |
    | |\\/| ||  _  | `--. \\ | | |  __||    /| |\\/| | | | | . ` | | | |
    | |  | || | | |/\\__/ / | | | |___| |\\ \\| |  | |_| |_| |\\  | |/ /
    \\_|  |_/\\_| |_/\\____/  \\_/ \\____/\\_| \\_\\_|  |_/\\___/\\_| \\_/___/
    '
  end

  def game_start_screen
    puts "
    \e[4mAbout the Game:\e[0m
      Mastermind or Master Mind is a code-breaking game for two players.
      In which one player is the \e[4mCodemaker\e[0m and the other the \e[4mCodebreaker\e[0m.
      This version of Mastermind \e[1mYou\e[0m will play against the \e[1mComputer\e[0m either as maker or breaker"
  end

  def game_rules
    puts "    \e[4mHow to Play:\e[0m
      \e[1mAs the Codemaker:\e[0m your only task will be to choose the code of the match,
      And the computer will have 12 rounds to correctly guess your code.
      The code is made of 4 digits being each one between 1-6

      \e[1mAs the Codebreaker:\e[0m the Computer will first select a random code
      which will not be shown to you, and you will have 12 rounds to type in a guess
      if you type a correct guess the game ends and you win, if you get 12 wrong guesses
      you lose the game. The guess is made of 4 digits being each one between 1-6

      \e[1mThe Code\e[0m will be represented by 6 bars each with a different color
      and their associated number written on them like this: #{@board.show_total_pegs}"
  end

  def last_rules
    puts "
      \e[1mMatches and Correct guesses:\e[0m each time the breaker makes a guess he will
      be given hints about how close he got, every time his guess has the same number
      then the code he will have a match, and every time a guess is the correnct number
      and in the correct spot it will be a correct guess."
  end

  # output the choice of the player
  # if he is going to be the maker or the braker
  def maker_breaker
    puts "
    \e[4mStart The game:\e[0m
      Are you going to play as code[M]aker or code[B]raker? Type the highlighted character of your choice"
    choice = gets.chomp.downcase
    return choice if %w[m b].include?(choice)

    maker_breaker
  end

  # The game flow if the player choses maker
  def game_maker
    @board.maker.create_number
    puts "Your code is: #{@board.format(@board.maker)}"
    @board.breaker.random_number
    breaker_rounds('computer')
  end

  # The game flow if the player choses breaker
  def game_breaker
    @board.maker.random_number
    @board.breaker.create_number
    breaker_rounds('player')
  end

  # check for game state
  def win?
    true if @board.maker.code == @board.breaker.guess
  end

  # win message
  def win_screen
    puts "Congratulations! You won!! The code was: #{@board.format(@board.maker)}"
  end

  # lost message and annouce what the code was
  def announce_code
    puts "\nYou lost :(  The code was:  #{@board.format(@board.maker)}"
  end
end
