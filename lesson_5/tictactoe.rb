require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('tictactoe_messages.yml') 

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

  def continue_program
    prompt_message('continue')
    gets
  end
end

class Board
  include ProgramFunctionality

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diag

  def initialize
  	@squares = {}
    reset
  end

  def draw
    clear_screen

    puts ""
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
    puts ""
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
    (1..9).each { |key| @squares[key] = Square.new }
  end
  
  def []=(num, marker)
    squares[num].marker = marker
  end
  
  private
  
  attr_reader :squares

  def three_identical_markers?(squares)
    marker = squares.select(&:marked?).map(&:marker)
    return false if marker.size != 3
    marker.min == marker.max
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

  attr_reader :marker, :difficulty

  def initialize(marker)
    @marker = marker
    set_difficulty if marker == TTTGame::COMPUTER_MARKER
  end

  def set_difficulty
    prompt_message('difficulty')

    loop do
      difficulty = gets.chomp[0]
  
      case difficulty
      when 'b' then return self.difficulty = 'Beginner'
      when 'm' then return self.difficulty = 'Medium'
      when 'h' then return self.difficulty = 'Hard'
      when 'e' then return self.difficulty = 'Expert'
      else     prompt_message('valid_diff')
      end
    end
  end

  private

  attr_writer :difficulty
end

class TTTGame
  include ProgramFunctionality

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
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

  def find_winning_square(marker)
    if board.values_at(*line).count(marker) == 2
      board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
    end
  end

  def offensive_mode(brd, square)
    WINNING_LINES.each do |line|
      square = find_winning_square(COMPUTER_MARKER)
      break if square
    end
  
    square
  end
  
  def defensive_mode
    WINNING_LINES.each do |line|
      square ||= find_winning_square(PLAYER_MARKER)
      break if square
    end
  
    square
  end
  
  def middle_square
    5 unless board[5].marked?
  end

  def computer_moves
    possible_moves = [middle_square,
                      offensive_mode,
                      defensive_mode,
                      unmarked_keys.sample]
    
    counter = Player::DIFFICULTY.index(difficulty)
    until counter > 3
      square ||= possible_moves[counter]
      counter += 1
    end

    board[square] = computer.marker
  end

  def display_result
    board.draw

    case board.winning_marker
    when human.marker then puts "You won!"
    when computer.marker then puts "Computer won!"
    else puts "It's a tie"
    end
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
      board.draw

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        board.draw
        # binding.pry
      end

      display_result
      break unless play_again?
      board.reset
    end
  end
end

class ProgramBootup
  include ProgramFunctionality

  attr_accessor :choice

  def initialize
    clear_screen
    directory
  end

  def display_directory
    clear_screen
    puts_message('directory')
  end

  def play_game

  end

  def play_classic_game
    TTTGame.new.play
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
