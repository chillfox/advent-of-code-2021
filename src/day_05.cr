path = "./data/day_05_test.txt" unless path = ARGV.first?

REGEX = /^(\d+),(\d+)\s->\s(\d+),(\d+)$/

def map_vents(path, diagonal = false)
  vents = Hash(Int64, Hash(Int64, Int64)).new
  File.each_line(path) do |line|
    raise "NO MATCH" unless match = REGEX.match(line)
    x1, y1, x2, y2 = match.captures.map &.as(String).to_i64

    if x1 == x2 # vertical
      # pp "(#{x1}): #{y1} -> #{y2}"
      if y1 <= y2 # top to bottom
        (y1..y2).each do |y|
          vents[y] ||= Hash(Int64, Int64).new
          vents[y][x1] = vents[y][x1]? ? vents[y][x1] + 1 : 1_i64
        end
      else # bottom to top
        (y2..y1).each do |y|
          vents[y] ||= Hash(Int64, Int64).new
          vents[y][x1] = vents[y][x1]? ? vents[y][x1] + 1 : 1_i64
        end
      end
    elsif y1 == y2 # horizontal
      # pp "(#{y1}): #{x1} -> #{x2}"
      y = vents[y1] ||= Hash(Int64, Int64).new
      if x1 <= x2 # left to right
        (x1..x2).each do |x|
          y[x] = y[x]? ? y[x] + 1 : 1_i64
        end
      else # right to left
        (x2..x1).each do |x|
          y[x] = y[x]? ? y[x] + 1 : 1_i64
        end
      end
    elsif diagonal && x1 != x2 && y1 != y2 # diagonal
      # pp "#{x1},#{y1} -> #{x2}, #{y2}"

      if y1 <= y2 && x1 <= x2 # top to bottom, left to right
        # pp "top to bottom, left to right"
        (y1..y2).each_with_index do |y, i|
          if (x1..x2).includes? x1 + i
            # pp "y#{y},x#{x1 + i}"
            vents[y] ||= Hash(Int64, Int64).new
            vents[y][x1 + i] = vents[y][x1 + i]? ? vents[y][x1 + i] + 1 : 1_i64
          end
        end
      elsif y1 <= y2 && x1 > x2 # top to bottom, right to left
        # pp "top to bottom, right to left"
        (y1..y2).each_with_index do |y, i|
          if (x2..x1).includes? x1 - i
            # pp "y#{y},x#{x1 - i}"
            vents[y] ||= Hash(Int64, Int64).new
            vents[y][x1 - i] = vents[y][x1 - i]? ? vents[y][x1 - i] + 1 : 1_i64
          end
        end
      elsif y1 > y2 && x1 <= x2 # bottom to top, left to right
        # pp "bottom to top, left to right"
        (y2..y1).each_with_index do |y, i|
          if (x1..x2).includes? x2 - i
            # pp "y#{y},x#{x2 - i}"
            vents[y] ||= Hash(Int64, Int64).new
            vents[y][x2 - i] = vents[y][x2 - i]? ? vents[y][x2 - i] + 1 : 1_i64
          end
        end
      else # bottom to top, right to left
        # pp "bottom to top, right to left"
        (y2..y1).each_with_index do |y, i|
          if (x2..x1).includes? x2 + i
            # pp "y#{y},x#{x2 + i}"
            vents[y] ||= Hash(Int64, Int64).new
            vents[y][x2 + i] = vents[y][x2 + i]? ? vents[y][x2 + i] + 1 : 1_i64
          end
        end
      end
    end
  end
  vents
end

# print map
def print_map(vents)
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

def overlap(vents)
  vents.map { |k, v| v.values }.flatten.count { |v| v > 1 }
end

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

vents = map_vents path

print_map vents
puts ""

puts "Overlap: #{overlap vents}"

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

vents = map_vents path, true

print_map vents
puts ""

puts "Overlap: #{overlap vents}"
