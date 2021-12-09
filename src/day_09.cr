path = "./data/day_09_test.txt" unless path = ARGV.first?

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

heightmap = [] of Array(Int32)

File.each_line(path) do |line|
  heightmap << Array(Int32).new line.size + 2, 10 if heightmap.empty?

  heightmap << [10, line.chars.map &.to_i, 10].flatten
end
heightmap << Array(Int32).new heightmap.first.size, 10

low_points = [] of Int32
heightmap.each_cons 3 do |row|
  row.transpose.each_cons 3 do |square|
    center = square[1][1]
    adjacent = [square[0][1], square[1][0], square[1][2], square[2][1]].flatten
    
    low_points << center if adjacent.min > center
  end
end

risk = low_points.size + low_points.sum
puts "Risk: #{risk}"
