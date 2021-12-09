# 7 segment display

#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....
#
#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

# digit | segments
# ----------------
# 0     | 6
# 1     | 2
# 2     | 5
# 3     | 5
# 4     | 4
# 5     | 5
# 6     | 6
# 7     | 3
# 8     | 7
# 9     | 6

# seg(digit) == segments in digit
# 0 | seg(0).size == 6 && (seg(0) - (seg(4) - seg(1))).size == 5
# 1 | seg(7).size == 2
# 2 | seg(2).size == 5 && (seg(2) - seg(9)).size == 1
# 3 | seg(3).size == 5 && (seg(3) - seg(7)).size == 2
# 4 | seg(7).size == 4
# 5 | seg(5).size == 5 && (seg(5) - seg(6)).size == 0
# 6 | seg(6).size == 6 && seg(6).count { |c| c == seg(1)[0] || c == seg(1)[1] } == 1
# 7 | seg(7).size == 3
# 8 | seg(7).size == 7
# 9 | seg(9).size == 6 && (seg(9) - seg(4)).size == 2

path = "./data/day_08_test.txt" unless path = ARGV.first?

notes = [] of NamedTuple(input: Array(String), output: Array(String))

File.each_line(path) do |line|
  note = {input: Array(String).new, output: Array(String).new}

  input = true
  line.split.each do |pattern|
    if pattern == "|"
      input = false
      next
    end
    if input
      note[:input] << pattern
    else
      note[:output] << pattern
    end
  end

  notes << note
end

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

# count digits: 1, 4, 7, 8
count = notes
  .map(&.[:output].map &.size)
  .flatten
  .tally
  .select { |k, v| k > 1 && k < 5 || k == 7 }
  .values
  .sum

puts "The digits 1, 4, 7 and 8 appears #{count} times."

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

def decode(input, known = nil)
  known ||= (0..9).to_h { |d| {d, ""} }

  input.each do |digit|
    case digit.size
    when 2 # digit: 1
      known[1] = digit.chars.sort.join
    when 3 # digit: 7
      known[7] = digit.chars.sort.join
    when 4 # digit: 4
      known[4] = digit.chars.sort.join
    when 5 # digits: 2, 3, 5

      next if known[9].blank?
      if (digit.chars - known[9].chars).size == 1
        known[2] = digit.chars.sort.join
      end

      next if known[7].blank?
      if (digit.chars - known[7].chars).size == 2
        known[3] = digit.chars.sort.join
      end

      next if known[6].blank?
      if (digit.chars - known[6].chars).size == 0
        known[5] = digit.chars.sort.join
      end
    when 6 # digits: 0, 6, 9

      next if known[4].blank?
      if (digit.chars - (known[4].chars - known[1].chars)).size == 5
        known[0] = digit.chars.sort.join
      end

      next if known[1].blank?
      if digit.count { |c| c == known[1][0] || c == known[1][1] } == 1
        known[6] = digit.chars.sort.join
      end

      if (digit.chars - known[4].chars).size == 2
        known[9] = digit.chars.sort.join
      end
    when 7 # digit: 8
      known[8] = digit.chars.sort.join
    end
  end

  inverted = known.map { |k, v| {v, k} }.to_h
  unknown = input.select { |i| !inverted[i.chars.sort.join]? }

  if unknown.size > 0
    decode unknown, known
  else
    known
  end
end

output_values = [] of Int32
notes.each do |note|
  codes = decode(note[:input]).map { |k, v| {v, k} }.to_h

  output_values << note[:output].map { |s| codes[s.chars.sort.join] }.join.to_i
end

puts "Sum of all output values: #{output_values.sum}"
