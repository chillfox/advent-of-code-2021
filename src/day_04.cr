path = "./data/day_04_test.txt" unless path = ARGV.first?

struct Board
  property rows = [] of Array(Num)

  def columns
    @rows.transpose
  end

  def unmarked
    @rows.map(&.select { |n| !n.marked }.map &.number).flatten
  end

  def mark(number)
    @rows.each do |row|
      row.select { |n| n.number == number }.map { |n| n.marked = true }
    end
  end

  def win : Bool
    rows.each do |row|
      return true if row.all? &.marked
    end
    columns.each do |column|
      return true if column.all? &.marked
    end
    false
  end

  class Num
    property marked
    getter number

    def initialize(@number = 0, @marked = false)
    end
  end
end

numbers = [] of Int64
boards = [] of Board

File.each_line(path) do |line|
  case line
  when /,/
    numbers = line.split(',').map &.to_i
  when ""
    boards << Board.new
  else
    boards.last.rows << line.split.map { |n| Board::Num.new n.to_i }
  end
end

puts "Boards: #{boards.size}"

first_winning_board = 0
first_winning_number = 0
first_winning_score = 0

last_winning_board = 0
last_winning_number = 0
last_winning_score = 0

numbers.each do |number|
  boards.each_with_index do |board, idx|
    next if board.win
    board.mark number
    if board.win
      last_winning_board = idx + 1
      last_winning_number = number
      last_winning_score = board.unmarked.sum * number

      next if first_winning_board > 0
      first_winning_board = idx + 1
      first_winning_number = number
      first_winning_score = board.unmarked.sum * number
    end
  end
  break if boards.all? &.win
end

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

puts "Winning Board: #{first_winning_board}"   # 3
puts "Winning Number: #{first_winning_number}" # 24
puts "Score: #{first_winning_score}"           # 4512

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

puts "Winning Board: #{last_winning_board}"   # 2
puts "Winning Number: #{last_winning_number}" # 13
puts "Score: #{last_winning_score}"           # 1924
