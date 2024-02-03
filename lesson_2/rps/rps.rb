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
  include Comparable

  attr_reader :value

  VALUES = %w(rock paper scissors lizard spock r p sc l sp)
  WINS = { 'rock' => %w(scissors lizard),
           'paper' => %w(rock spock),
           'scissors' => %w(paper lizard),
           'lizard' => %w(paper spock),
           'spock' => %w(scissors rock) }

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

  def <=>(other)
    if value == other.value
      0
    elsif WINS[value].include?(other.value)
      1
    else
      -1
    end
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
      n = gets.chomp.capitalize.strip
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

  attr_accessor :human, :computer, :round, :max_rounds

  @@human_wins = 0
  @@total_rounds = 0
  @@moves = []
  @@tied_games = 0

  def initialize
    clear_screen
    puts_message('setup')
    @human = Human.new
    @computer = Computer.new
    determine_total_rounds
    @round = 1
  end

  def self.calc_percent(player_wins, total_rounds)
    ((player_wins / total_rounds.to_f) * 100).to_i
  end

  def self.display_statistics(favorite, fav_count)
    puts "GAME STATISTICS\n\n"
    puts "Total Rounds: #{@@total_rounds}"
    puts "Player Win Percentage: #{calc_percent(@@human_wins, @@total_rounds)}%"
    puts "Favorite Move: #{favorite.capitalize} (used #{fav_count} time(s))"
    puts "Tied Games: #{@@tied_games}\n\n"
  end

  def self.game_stats
    favorite = @@moves.max_by { |move| @@moves.count(move) }
    fav_count = @@moves.count(favorite)

    if @@total_rounds == 0
      puts MESSAGES['no_stats']
    else
      display_statistics(favorite, fav_count)
    end
  end

  def players_choose
    clear_screen

    display_round_info
    human.choose
    computer.choose

    @@moves << human.move.value
  end

  def display_board(counter)
    clear_screen

    display_round_info
    puts human.name.center(30)
    puts_message(counter == 0 ? 'blank_square' : human.move.value)

    puts computer.name.center(30)
    puts_message(counter == 2 ? computer.move.value : 'blank_square')
  end

  def convert_to_i
    self.max_rounds = max_rounds.to_i
  end

  def determine_total_rounds
    prompt_message('select_total')

    loop do
      self.max_rounds = gets.chomp
      break convert_to_i if %w(1 3 5 7 9).include?(max_rounds)
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

    if winner == 'tie'
      puts "It's a tie!\n"
    else
      puts_message("#{winner.move}#{loser.move}")
      sleep(1)
      puts "#{winner.name} wins!\n\n"
      increment_score(winner)
      increment_round
    end
  end

  def format_score(player)
    "#{player.name}: #{player.score}"
  end

  def display_round_info
    puts "Best of #{max_rounds}".center(30)
    puts "ROUND #{round}".center(30)
    puts "#{format_score(human)} | #{format_score(computer)}\n".center(30)
  end

  def display_grand_champion
    champion = [human, computer].max_by(&:score)

    clear_screen
    display_round_info
    puts "#{champion.name} is the GRAND CHAMPION!\n\n"
  end

  def winner?
    human.score > max_rounds / 2 ||
      computer.score > max_rounds / 2
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

  def reset_game
    [human, computer].each { |player| player.score = 0 }
    self.round = 1
  end

  def main_game
    until winner?
      players_choose
      display_moves
      display_winner
      continue?
      @@total_rounds += 1
    end
  end

  def play
    loop do
      main_game
      display_grand_champion
      break unless play_again?
      reset_game
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

  def play_game
    @@games_played += 1
    RPSGame.new.play
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
    valid_choices = %w(1 2 3 4)
    loop do
      self.choice = gets.chomp
      break if valid_choices.include?(choice)
      prompt_message('invalid_directory')
    end
  end

  def directory
    loop do
      display_welcome_message
      choose_directory

      case choice
      when '1' then play_game
      when '2' then display_instructions
      when '3' then display_game_stats
      when '4' then display_closing_message || break
      end
    end
  end
end

ProgramBootup.new
