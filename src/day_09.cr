path = "./data/day_09_test.txt" unless path = ARGV.first?

heightmap = [] of Array(Int32)

File.each_line(path) do |line|
  heightmap << Array(Int32).new line.size + 2, 10 if heightmap.empty?

  heightmap << [10, line.chars.map &.to_i, 10].flatten
end
heightmap << Array(Int32).new heightmap.first.size, 10

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

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

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

def fill_basin(x, y, index, basins)
  return if basins[y][x] > 8 || basins[y][x] < 0
  basins[y][x] = index

  fill_basin x - 1, y, index, basins
  fill_basin x + 1, y, index, basins
  fill_basin x, y - 1, index, basins
  fill_basin x, y + 1, index, basins
end

basins = heightmap.clone
basin_index = 0
basins[1..-2].each_with_index do |y, y_idx|
  y[1..-2].each_with_index do |x, x_idx|
    next if x > 8 || x < 0
    basin_index -= 1
    fill_basin x_idx + 1, y_idx + 1, basin_index, basins
  end
end

# pp basins
large_basin_product = basins
  .flatten
  .select { |n| n < 0 }
  .tally
  .values
  .sort
  .last(3)
  .product

puts "3 Largest basins multiplied: #{large_basin_product}"
