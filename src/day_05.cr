path = "./data/day_05_test.txt" unless path = ARGV.first?

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

vents = Hash(Int64, Hash(Int64, Int64)).new
# vents = [] of Array(Int64)

REGEX = /^(\d+),(\d+)\s->\s(\d+),(\d+)$/
File.each_line(path) do |line|
  raise "NO MATCH" unless match = REGEX.match(line)
  x1, y1, x2, y2 = match.captures.map &.as(String).to_i64

  if x1 == x2
    # vertical line
    # pp "(#{x1}): #{y1} -> #{y2}"

    if y1 <= y2
      (y1..y2).each do |y|
        vents[y] ||= Hash(Int64, Int64).new
        vents[y][x1] = vents[y][x1]? ? vents[y][x1] + 1 : 1_i64
      end
    else
      (y2..y1).each do |y|
        vents[y] ||= Hash(Int64, Int64).new
        vents[y][x1] = vents[y][x1]? ? vents[y][x1] + 1 : 1_i64
      end
    end
  elsif y1 == y2
    # horizontal line
    # pp "(#{y1}): #{x1} -> #{x2}"

    y = vents[y1] ||= Hash(Int64, Int64).new
    if x1 <= x2
      (x1..x2).each do |x|
        y[x] = y[x]? ? y[x] + 1 : 1_i64
      end
    else
      (x2..x1).each do |x|
        y[x] = y[x]? ? y[x] + 1 : 1_i64
      end
    end
  end
end

# print map
def print_map
  max_y = vents.keys.max
  max_x = (vents.map &.last.keys.max).max
  puts (0..max_x).map { "##" }.join
  (0..max_y).each do |y|
    line = (0..max_x).map { "." }.join " "
    if vents[y]?
      line = (0..max_x).map { |x| vents[y][x]? ? vents[y][x] : "." }.join " "
    end
    puts line
  end
  puts (0..max_x).map { "##" }.join
end

print_map
puts ""

overlap = vents.map { |k, v| v.values }.flatten.count { |v| v > 1 }
puts "Overlap: #{overlap}"
