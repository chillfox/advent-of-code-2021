path = "./data/day_02_test.txt" unless path = ARGV.first?

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

position = 0
depth = 0

File.each_line(path) do |line|
  cmd, num = line.split

  case cmd
  when "forward"
    position += num.to_i64
  when "down"
    depth += num.to_i64
  when "up"
    depth -= num.to_i64
  end
end

puts "Position: #{position}, Depth: #{depth}"
puts "Answer: #{position * depth}"

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

position = 0
depth = 0
aim = 0

File.each_line(path) do |line|
  cmd, num = line.split

  case cmd
  when "forward"
    position += num.to_i64
    depth += aim * num.to_i64
  when "down"
    aim += num.to_i64
  when "up"
    aim -= num.to_i64
  end
end

puts "Position: #{position}, Depth: #{depth}, Aim: #{aim}"
puts "Answer: #{position * depth}"
