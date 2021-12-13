path = "./data/day_10_test.txt" unless path = ARGV.first?

lines = File.read(path).lines

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

ERROR_POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

def parse_error?(tokens : Array(Char), parents : Array(Char) = [] of Char) : Char?
  return nil if tokens.empty?
  token = tokens.shift

  opening = ['(', '[', '{', '<']
  closing = [')', ']', '}', '>']

  if !parents.empty? && closing.includes? token
    raise "Panic!" unless index = opening.index parents.last

    if closing[index] == token
      # pp "#{parents} #{index} #{token}"
      if tokens.empty?
        nil
      else
        parents.pop
        parse_error? tokens, parents
      end
    else
      token
    end
  else
    parents << token
    parse_error? tokens, parents
  end
end

error_score = 0

lines.each do |line|
  if error = parse_error? line.chars
    error_score += ERROR_POINTS[error]
  end
end

puts "#{error_score} points"

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

COMPLETION_POINTS = {
  ')' => 1_i64,
  ']' => 2_i64,
  '}' => 3_i64,
  '>' => 4_i64,
}

def flip(char : Char) : Char
  case char
  when '('
    ')'
  when '['
    ']'
  when '{'
    '}'
  when '<'
    '>'
  else
    '?'
  end
end

def parse_complete?(tokens : Array(Char), parents : Array(Char) = [] of Char) : Array(Char)?
  return nil if tokens.empty?
  token = tokens.shift

  opening = ['(', '[', '{', '<']
  closing = [')', ']', '}', '>']

  if !parents.empty? && closing.includes? token
    raise "Panic!" unless index = opening.index parents.last

    if closing[index] == token
      # pp "#{parents.last} #{index} #{token}"
      parents.pop
      if tokens.empty?
        parents.reverse.map { |c| flip c }
      else
        parse_complete? tokens, parents
      end
    else
      parents.reverse.map { |c| flip c }
    end
  else
    parents << token
    if tokens.empty?
      parents.reverse.map { |c| flip c }
    else
      parse_complete? tokens, parents
    end
  end
end

completion_score = [] of Int64

lines.each do |line|
  unless parse_error? line.chars
    if completion = parse_complete? line.chars
      score = 0_i64
      completion.each do |char|
        score *= 5_i64
        score += COMPLETION_POINTS[char]
      end
      completion_score << score
    end
  end
end

winner = completion_score.sort[completion_score.size // 2]

puts "Middle score: #{winner} points"
