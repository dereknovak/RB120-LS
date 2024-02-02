require 'yaml'
require 'pry'
MESSAGES = YAML.load_file('rps_messages.yml')

module ProgramFunctionality
  def clear_screen
    system('clear') || system('cls')
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def prompt_message(message)
    prompt(MESSAGES[message])
  end

  def puts_message(message)
    puts MESSAGES[message]
  end

  def continue?
    prompt_message('continue')
    gets
  end
end

class Move
  attr_reader :value

  VALUES = %w(rock paper scissors lizard spock)

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end


  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.paper? || other_move.spock?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.paper? || other_move.lizard?))
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''

    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "Sorry, must enter a value."
    end

    self.name = n
  end

  def choose
    choice = nil

    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end

    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny C3PO).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  include ProgramFunctionality

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def puts_message(message)
    puts MESSAGES[message]
  end

  def display_board(counter)
    clear_screen
    puts human.name.center(30)
    puts ''
    counter == 0 ? puts_message('blank_square') : puts_message(human.move.value)

    puts computer.name.center(30)
    puts ''
    counter == 2 ? puts_message(computer.move.value) : puts_message('blank_square')
  end

  def display_moves
    3.times do |counter|
      display_board(counter)
      sleep(1) if counter < 2
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def play
    loop do
      clear_screen
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
  end
end

class ProgramBootup
  include ProgramFunctionality

  attr_accessor :choice

  @@games_played = 0

  def initialize
    clear_screen
    directory
  end

  def display_welcome_message
    clear_screen
    puts_message('welcome')
  end

  def display_instructions
    clear_screen
    puts_message('instructions')
    continue?
  end

  def display_closing_message
    clear_screen
    puts_message('goodbye')
  end

  def choose_directory
    valid_choices = [1, 2, 3]
    loop do
      self.choice = gets.chomp.to_i
      break if valid_choices.include?(choice)
      prompt_message('valid_directory')
    end
  end

  def directory
    loop do
      display_welcome_message
      choose_directory

      case choice
      when 1
        @@games_played += 1
        RPSGame.new.play
      when 2
        display_instructions
      when 3
        display_closing_message
        break
      else
        prompt_message('invalid_directory')
      end
    end
  end
end

ProgramBootup.new

