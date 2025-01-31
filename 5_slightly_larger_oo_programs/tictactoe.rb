require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('tictactoe_messages.yml')

module Displayable
  def display_screen_prompt
    puts_message('full_screen')
    clear_screen
  end

  def display_board
    clear_screen
    super_board.draw
  end

  def display_round_info
    puts "Best of #{max_rounds}".center(30)
    puts "ROUND #{round}".center(30)
    puts "#{format_score(human)} | #{format_score(computer)}\n".center(30)
  end

  # def display_board
  #   clear_screen
  #   display_round_info
  #   board.draw
  # end

  def display_results
    display_board

    case board.winning_marker
    when human.marker
      puts_message('human_win')
      self.round += 1
      human.score += 1
    when computer.marker
      puts_message('computer_win')
      self.round += 1
      computer.score += 1
    else
      puts_message('tie')
    end
  end

  def display_grand_champion
    clear_screen

    display_round_info
    case grand_champion
    when human
      puts_message('player_champion')
    when computer
      puts_message('computer_champion')
    end
  end

  def display_directory
    clear_screen
    puts_message('directory')
  end

  def display_instructions
    clear_screen
    puts_message('instructions')
    continue_program
  end

  # def display_game_stats
  #   clear_screen
  #   RPSGame.game_stats
  #   continue_program
  # end

  def display_closing_message
    clear_screen
    puts_message('goodbye')
  end
end

module ProgramFunctionality
  def clear_screen
    system('clear') || system('cls')
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def message(message)
    MESSAGES[message]
  end

  def prompt_message(message)
    prompt(MESSAGES[message])
  end

  def puts_message(message)
    puts MESSAGES[message]
  end

  def continue_program
    prompt_message('continue')
    gets
  end

  def joinor(arr, separator = ',', preposition = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first.to_s
    when 2 then arr.join(" #{preposition} ")
    else
      arr[-1] = "#{preposition} #{arr.last}"
      arr.join("#{separator} ")
    end
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
  [[1, 5, 9], [3, 5, 7]]              # diag

  def initialize
    reset
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    
    nil
  end
  
  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end

  def [](num)
    squares[num]
  end
  
  def []=(num, marker)
    squares[num].marker = marker
  end
  
  attr_reader :squares
  
  private
  
  def three_identical_markers?(squares)
    marker = squares.select(&:marked?).map(&:marker)
    return false if marker.size != 3
    marker.min == marker.max
  end
end

class SuperBoard < Board
  include ProgramFunctionality

  
  attr_reader :big_squares
  
  def initialize
    @big_squares = {}
    super
  end

  def reset
    (1..9).each { |key| @big_squares[key] = ClassicBoard.new }
  end

  def draw
    puts (format(message('super_board'), one1: big_squares[1][1], one2: big_squares[1][2], one3: big_squares[1][3], one4: big_squares[1][4], one5: big_squares[1][5], one6: big_squares[1][6], one7: big_squares[1][7], one8: big_squares[1][8], one9: big_squares[1][9],
                                         two1: big_squares[2][1], two2: big_squares[2][2], two3: big_squares[2][3], two4: big_squares[2][4], two5: big_squares[2][5], two6: big_squares[2][6], two7: big_squares[2][7], two8: big_squares[2][8], two9: big_squares[2][9],
                                         thr1: big_squares[3][1], thr2: big_squares[3][2], thr3: big_squares[3][3], thr4: big_squares[3][4], thr5: big_squares[3][5], thr6: big_squares[3][6], thr7: big_squares[3][7], thr8: big_squares[3][8], thr9: big_squares[3][9],
                                         fou1: big_squares[4][1], fou2: big_squares[4][2], fou3: big_squares[4][3], fou4: big_squares[4][4], fou5: big_squares[4][5], fou6: big_squares[4][6], fou7: big_squares[4][7], fou8: big_squares[4][8], fou9: big_squares[4][9],
                                         fiv1: big_squares[5][1], fiv2: big_squares[5][2], fiv3: big_squares[5][3], fiv4: big_squares[5][4], fiv5: big_squares[5][5], fiv6: big_squares[5][6], fiv7: big_squares[5][7], fiv8: big_squares[5][8], fiv9: big_squares[5][9],
                                         six1: big_squares[6][1], six2: big_squares[6][2], six3: big_squares[6][3], six4: big_squares[6][4], six5: big_squares[6][5], six6: big_squares[6][6], six7: big_squares[6][7], six8: big_squares[6][8], six9: big_squares[6][9],
                                         sev1: big_squares[7][1], sev2: big_squares[7][2], sev3: big_squares[7][3], sev4: big_squares[7][4], sev5: big_squares[7][5], sev6: big_squares[7][6], sev7: big_squares[7][7], sev8: big_squares[7][8], sev9: big_squares[7][9],
                                         eig1: big_squares[8][1], eig2: big_squares[8][2], eig3: big_squares[8][3], eig4: big_squares[8][4], eig5: big_squares[8][5], eig6: big_squares[8][6], eig7: big_squares[8][7], eig8: big_squares[8][8], eig9: big_squares[8][9],
                                         nin1: big_squares[9][1], nin2: big_squares[9][2], nin3: big_squares[9][3], nin4: big_squares[9][4], nin5: big_squares[9][5], nin6: big_squares[9][6], nin7: big_squares[9][7], nin8: big_squares[9][8], nin9: big_squares[9][9]))
      
  end
end

class ClassicBoard < Board
  include ProgramFunctionality

  attr_accessor :squares, :completed

  def initialize
  	@squares = {}
    @completed = false
    super
  end

  def draw
    puts (format(message('board'), one: squares[1], two: squares[2], thr: squares[3],
                                   fou: squares[4], fiv: squares[5], six: squares[6],
                                   sev: squares[7], eig: squares[8], nin: squares[9]))
  end

  def fill_squares(player)
    self.reset
    case player.name
    when 'Computer' then [2, 4, 6, 8].each { |num| squares[num] = player.marker }
    else                 [1, 3, 5, 7, 9].each { |num| squares[num] = player.marker }
    end
  end
end

class Square
  attr_accessor :marker

  INITIAL_MARKER = " "

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end
  
  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  include ProgramFunctionality

  DIFFICULTY = %w(Expert Hard Medium Beginner)

  attr_accessor :score
  attr_reader :marker, :difficulty, :name

  def initialize(marker, name="Human")
    @marker = marker
    @name = name
    @score = 0
    set_difficulty if @name == 'Computer'
  end

  def set_difficulty
    prompt_message('difficulty')

    loop do
      difficulty = gets.chomp.downcase[0]
  
      case difficulty
      when 'b' then return self.difficulty = 'Beginner'
      when 'm' then return self.difficulty = 'Medium'
      when 'h' then return self.difficulty = 'Hard'
      when 'e' then return self.difficulty = 'Expert'
      else     prompt_message('valid_diff')
      end
    end

    def to_s
      name
    end
  end

  private

  attr_writer :difficulty
end

class TTTGame

end

class SuperTTTGame < TTTGame
  include ProgramFunctionality, Displayable

  attr_accessor :super_board, :current_square
  attr_reader :human, :computer
  
  def initialize
    player_setup
  end

  def play
    loop do
      display_screen_prompt
      super_board.draw
   
      until winner?
        human_moves
        display_board
        sleep(0.5)
        computer_moves
        display_board
      end

      display_winner
      break unless play_again?
      super_board.reset
    end
  end

  def winner?
    
  end

  def player_setup
    name = nil
    human_marker = nil
    computer_marker = nil

    prompt_message('name?')
    loop do
      name = gets.chomp.capitalize
      break unless name.strip.empty? || name.split.size > 1
      prompt_message('valid_name')
    end

    prompt_message('human_marker?')
    loop do
      human_marker = gets.chomp
      break unless human_marker.strip.empty? || human_marker.length > 1
      prompt_message('valid_marker')
    end

    prompt_message('computer_marker?')
    loop do
      computer_marker = gets.chomp
      break unless computer_marker.strip.empty? || computer_marker.length > 1
      prompt_message('valid_marker')
    end

    @super_board = SuperBoard.new
    @human = Player.new(human_marker, name)
    @computer = Player.new(computer_marker, 'Computer')
  end

  def human_moves
    unless current_square && !(super_board.big_squares[current_square].completed)
      puts "Choose a large square:"
      loop do
        self.current_square = gets.chomp.to_i
        if super_board.big_squares[current_square].completed
          prompt_message('completed_square')
        elsif current_square == nil
          prompt_message('valid_square')
        elsif (1..9).to_a.include?(current_square)
          break
        else
          prompt_message('valid_square')
        end
      end
    end
    # binding.pry
    puts "Choose a square in large square # #{current_square} (#{joinor(super_board.big_squares[current_square].unmarked_keys)})"
    
    square = nil
    loop do
      square = gets.chomp.to_i
      break if super_board.big_squares[current_square].unmarked_keys.include?(square)
      prompt_message('valid_square')
    end

    super_board.big_squares[current_square][square] = human.marker

    if super_board.big_squares[current_square].winning_marker
      super_board.big_squares[current_square].fill_squares(human)
      super_board.big_squares[current_square].completed = true
    end

    self.current_square = square
  end

  def computer_moves
    if super_board.big_squares[current_square].completed
      self.current_square = super_board.big_squares.keys.reject { |square| super_board.big_squares[square].completed }.sample
    end

    square = nil
    possible_moves = [middle_square,
                      offensive_mode(square),
                      defensive_mode(square),
                      super_board.big_squares[current_square].unmarked_keys.sample]
                      
    counter = Player::DIFFICULTY.index(computer.difficulty)
    until counter > 3
      square ||= possible_moves[counter]
      counter += 1
    end

    super_board.big_squares[current_square][square] = computer.marker

    if super_board.big_squares[current_square].winning_marker
      super_board.big_squares[current_square].fill_squares(computer)
      super_board.big_squares[current_square].completed = true
    end
    self.current_square = square
  end

  def find_unmarked_square(line)
    super_board.big_squares[current_square].squares.select { |num, square| line.include?(num) && square.unmarked? }.keys.first
  end

  def find_winning_square(line, marker)
    if super_board.big_squares[current_square].squares.values_at(*line).map(&:marker).count(marker) == 2
      find_unmarked_square(line)
    end
  end

  def offensive_mode(square)
    Board::WINNING_LINES.each do |line|
      square ||= find_winning_square(line, computer.marker)
      break if square
    end
  
    square
  end
  
  def defensive_mode(square)
    Board::WINNING_LINES.each do |line|
      square ||= find_winning_square(line, human.marker)
      break if square
    end
  
    square
  end
  
  def middle_square
    5 unless super_board.big_squares[current_square][5].marked?
  end

end

class ClassicTTTGame < TTTGame
  include ProgramFunctionality, Displayable

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer, :round, :max_rounds, :grand_champion
  
  def initialize
    game_setup
  end

  

  def game_setup
    clear_screen
    
    puts_message('setup')
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER, 'Computer')
    @max_rounds = determine_total_rounds
    @current_marker = FIRST_TO_MOVE
    @round = 1
  end

  def valid_integer?(num)
    %w(1 3 5 7 9).include?(num) && num.to_i == num.to_f
  end

  def determine_total_rounds
    prompt_message('select_total')

    loop do
      @max_rounds = gets.chomp
      return max_rounds.to_i if valid_integer?(max_rounds)
      prompt_message('invalid_total')
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def switch_turn
    @current_marker = (human_turn? ? COMPUTER_MARKER : HUMAN_MARKER)
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
    else
      computer_moves
    end

    switch_turn
  end

  def human_moves
    puts "Choose a square. (#{joinor(board.unmarked_keys)})"

    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def find_unmarked_square(line)
    board.squares.select { |num, square| line.include?(num) && square.unmarked? }.keys.first
  end

  def find_winning_square(line, marker)
    if board.squares.values_at(*line).map(&:marker).count(marker) == 2
      find_unmarked_square(line)
    end
  end

  def offensive_mode(square)
    Board::WINNING_LINES.each do |line|
      square ||= find_winning_square(line, COMPUTER_MARKER)
      break if square
    end
  
    square
  end
  
  def defensive_mode(square)
    Board::WINNING_LINES.each do |line|
      square ||= find_winning_square(line, HUMAN_MARKER)
      break if square
    end
  
    square
  end
  
  def middle_square
    5 unless board[5].marked?
  end

  def computer_moves
    square = nil
    possible_moves = [middle_square,
                      offensive_mode(square),
                      defensive_mode(square),
                      board.unmarked_keys.sample]
                      
    counter = Player::DIFFICULTY.index(computer.difficulty)
    until counter > 3
      square ||= possible_moves[counter]
      counter += 1
    end

    board[square] = computer.marker
  end

  def increment_score
    case board.winning_marker
    when human.marker then human.score += 1
    when computer.marker then computer.score += 1
    end
  end

  def format_score(player)
    "#{player.name}: #{player.score}"
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

  def grand_champion?
    human.score > (max_rounds / 2) ||
      computer.score > (max_rounds / 2)
  end

  def determine_grand_champion
    @grand_champion = [human, computer].max_by(&:score)
  end

  def reset_game
    @grand_champion = nil
    @round = 1
    [human, computer].each { |player| player.score = 0 }
  end

  
  
  def play
    loop do
      until grand_champion?
        display_board

        loop do
          current_player_moves
          break if board.someone_won? || board.full?
          display_board
        end

        display_results
        continue_program
        board.reset
      end

      determine_grand_champion
      display_grand_champion
      break unless play_again?
      reset_game
    end
  end

  private

  attr_writer :round, :score
end

class ProgramBootup
  include ProgramFunctionality, Displayable

  attr_accessor :choice
  attr_reader :game

  def initialize
    clear_screen
    directory
  end

  def play_game
    @game = SuperTTTGame.new.play
  end

  def play_classic_game
    @game = ClassicTTTGame.new.play
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
      display_directory
      choose_directory

      case choice
      when '1' then play_game
      when '2' then display_instructions
      when '3' then play_classic_game
      when '4' then display_closing_message || break
      end
    end
  end
end

ProgramBootup.new
