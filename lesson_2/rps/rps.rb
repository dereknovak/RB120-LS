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

  VALUES = %w(rock paper scissors lizard spock r p sc l sp)

  def initialize(value)
    @value = value
    convert_value_to_full
  end

  def convert_value_to_full
    case value
    when 'r' then @value = 'rock'
    when 'p' then @value = 'paper'
    when 'sc' then @value = 'scissors'
    when 'l' then @value = 'lizard'
    when 'sp' then @value = 'spock'
    end
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
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  include ProgramFunctionality

  def set_name
    n = ''
    prompt_message('name?')

    loop do
      n = gets.chomp.capitalize
      break unless n.empty?
      prompt_message('invalid_name')
    end

    self.name = n
  end

  def choose
    choice = nil
    puts_message('select_move')

    loop do
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      prompt_message('invalid_move')
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

  attr_accessor :human, :computer, :round, :total_rounds, :total_games

  @@human_wins = 0
  @@total_games = 0
  @@moves_used = []
  @@tied_games = 0

  def initialize
    clear_screen
    puts_message('setup')
    @human = Human.new
    @computer = Computer.new
    determine_total_rounds
    @round = 1
  end

  def self.game_stats
    favorite_word = @@moves_used.max_by { |move| @@moves_used.count(move) }

    unless @@total_games == 0
      puts "GAME STATISTICS\n\n"
      puts "Total Rounds: #{@@total_games}"
      puts "Player Win Percentage: #{((@@human_wins / @@total_games.to_f) * 100).to_i}%"
      puts "Favorite Move: #{favorite_word.capitalize} (used #{@@moves_used.count(favorite_word)} time(s))"
      puts "Tied Games: #{@@tied_games}"
      puts ''
    else
      puts MESSAGES['no_stats']
    end
  end

  def players_choose
    clear_screen

    display_round_info
    human.choose
    computer.choose

    @@moves_used << human.move.value
  end

  def display_board(counter)
    clear_screen
    display_round_info
    puts human.name.center(30)
    puts ''
    counter == 0 ? puts_message('blank_square') : puts_message(human.move.value)

    puts computer.name.center(30)
    puts ''
    counter == 2 ? puts_message(computer.move.value) : puts_message('blank_square')
  end

  def determine_total_rounds
    prompt_message('select_total')

    loop do
      @total_rounds = gets.chomp.to_i
      break if @total_rounds.odd? && total_rounds < 10
      prompt_message('invalid_total')
    end
  end

  def display_moves
    3.times do |counter|
      display_board(counter)
      sleep(0.5)
    end
  end

  def increment_score(player)
    player.score += 1
  end

  def increment_round
    self.round += 1 unless winner?
  end

  def round_results
    if human.move > computer.move
      @@human_wins += 1
      [human, computer]
    elsif human.move < computer.move
      [computer, human]
    else
      @@tied_games += 1
      ['tie', 'tie']
    end
  end

  def display_winner
    winner, loser = round_results

    unless winner == 'tie'
      puts_message("#{winner.move}#{loser.move}")
      sleep(1.2)
      puts "#{winner.name} wins!\n"
      increment_score(winner)
      increment_round
    else
      puts "It's a tie!\n"
    end
  end

  def display_round_info
    puts "Best of #{total_rounds}".center(30)
    puts "ROUND #{round}".center(30)
    puts "#{human.name}: #{human.score} | #{computer.name}: #{computer.score}\n".center(30)
  end

  def display_grand_champion
    champion = [human, computer].max_by(&:score)

    clear_screen
    display_round_info
    puts "#{champion.name} is the GRAND CHAMPION!\n\n"
  end

  def winner?
    human.score > total_rounds / 2 ||
      computer.score > total_rounds / 2
  end

  def play_again?
    answer = nil
    prompt_message('again?')

    loop do
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      prompt_message('invalid_response')
    end

    answer == 'y'
  end

  def play
    loop do
      until winner?
        players_choose
        display_moves
        display_winner
        continue?
        @@total_games += 1
      end

      display_grand_champion
      break unless play_again?
      [human, computer].each { |player| player.score = 0 }
      self.round = 1
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

  def display_game_stats
    clear_screen

    RPSGame.game_stats
    continue?
  end

  def display_closing_message
    clear_screen
    puts_message('goodbye')
  end

  def choose_directory
    valid_choices = [1, 2, 3, 4]
    loop do
      self.choice = gets.chomp.to_i
      break if valid_choices.include?(choice)
      prompt_message('invalid_directory')
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
        display_game_stats
      when 4
        display_closing_message
        break
      else
        prompt_message('invalid_directory')
      end
    end
  end
end

ProgramBootup.new

