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

# puts "\n\n"
# puts "First Challenge"
# puts "########################################"
# puts "\n"

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

# count digits: 1, 4, 7, 8
count = notes.map(&.[:output].map &.size).flatten.tally.select { |k, v| k > 1 && k < 5 || k == 7 }.values.sum

puts "The digits 1, 4, 7 and 8 appears #{count} times."
